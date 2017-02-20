//
//  Constants.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/17/16.
//  Copyright © 2016 admin. All rights reserved.
//

import ARSLineProgress

let kGoogleNewsRSSURL = "http://news.google.com/?output=rss"
//let kGoogleNewsRSSURL = "https://news.google.com/news?cf=all&hl=en&pz=1&ned=us&csid=ac477c7aad18768f&output=rss"
//let kGoogleNewsRSSURL = "https://news.google.com/news?cf=all&hl=en&pz=1&ned=us&topic=s&output=rss"
//let kGoogleNewsRSSURL="http://www.atpworldtour.com/en/media/rss-feed/xml-feed"
let kHTTPResponseStatusCodeSuccess = 200

let kGoogleNewsArticleDateFormat = "EEE, d MMM yyyy HH:mm:ss Z"

// Regular Expressions
let kImgTagRegEx = "<img src=[^>]+>"
let kImgTagUrlRegEx = "\"//(.*?)\""

// Error Messages
let kNetworkFailureMessage = "There was a problem downloading articles. Please check your network connetion and try again"
let kParsingErrorMessage = "The was a problem parsing downloaded articles. Please try again."
let kUnknownErrorMessage = "There was a problem downloading articles. Please try again later."

let screenSize = UIScreen.main.bounds.size

