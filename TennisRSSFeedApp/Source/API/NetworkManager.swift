//
//  NetworkManager.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case networkFailure
    case parsingError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .networkFailure:
            return "No Network Connection"
            
        case .parsingError:
            return "Data Parsing Error"
            
        default:
            return "Unknown Error"
        }
    }
}

class NetworkManager: NSObject {

    // The intital entry point for fetching articles
    // This method takes make a network request to the Google News RSS feed and returns an NSData object and/or a custom NetworkError ErrorType object I have defined above
    func fetchAllArticlesWithCompletion(_ completion: @escaping (_ data: AnyObject?, _ error: Error?) -> Void) {
        
        let request = URLRequest(url: URL(string: kGoogleNewsRSSURL)!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let parsedResponse = response as? HTTPURLResponse {
                
                if (data != nil) && (error == nil) && (parsedResponse.statusCode == kHTTPResponseStatusCodeSuccess) {
                    // good data, no error, good response status code
                    completion(data as AnyObject?, nil)
                } else {
                    if error != nil {
                        // check error returned first
                        if let errorCode = error?._code {
                            switch errorCode {
                            case NSURLErrorNotConnectedToInternet:
                                completion(nil, NetworkError.networkFailure)
                                
                            default:
                                completion(nil, NetworkError.unknownError)
                            }
                        }
                    } else {
                        // non-success status codes and catch all
                        completion(nil, NetworkError.unknownError)
                    }
                }
            }
        }) .resume()
    }
    
    // This method takes in an NSData object and runs it through my parser class to parse the XML
    // It returns an array of ArticlePrototype structs (the prototype object used to create my Article NSManagedObject, and/or a ParsingError
    func parseAllArticleData(_ data: Data, completion: @escaping (_ content: [ArticlePrototype]?, _ error: Error?) -> Void) {
        
        let articleParser = ArticleParser(data: data)
        
        articleParser.parseDataWithCompletion { (success) -> Void in
            if success {
                
                // try core data
                CoreDataManager().cacheFetchedArticles(articleParser.articles)
                
                completion(articleParser.articles, nil)
            } else {
                completion(nil, NetworkError.parsingError)
            }
        }
    }
    
    // This method takes in an array of ArticlePrototype objects, fetches the image for each object, and retuns are new array of ArticlePrototype objects with image properties
    func downloadImagesForArticles(_ articles: [ArticlePrototype], completion: @escaping (_ articles: [ArticlePrototype]) -> Void) {
        
        if articles.isEmpty {
            completion(articles)
        }
        
        var articlesWithImages = [ArticlePrototype]()
        
        var index = 0
        
        for var article in articles {
            if let articleImageUrl = article.imageURL, articleImageUrl != "" {
                self.fetchImageFromURL(articleImageUrl, completion: { (image) -> Void in
                    article.image = image
                    
                    articlesWithImages.append(article)
                    
                    index += 1
                    
                    if index == articles.count {
                        completion(articlesWithImages)
                    }
                    
                })
            }
            
        }
    }
    
    // This method is used internally by downloadImagesForArticles
    // It performs the web request to fetch the data associated with an image URL, and return a UIIimage
    func fetchImageFromURL(_ url: String, completion:@escaping (_ image: UIImage?) -> Void) {
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if data != nil {
                
                if let unwrappedData = data as Data! {
                    completion(UIImage(data: unwrappedData))
                }
            } else {
                completion(nil)
            }
        }) .resume()
    }
}
