//
//  MusicViewController.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/16/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var audioPlayer: AVAudioPlayer!
    var musicItems:NSMutableArray!
    var timer: Timer!
    var playingIndexPath: IndexPath!
    
    //MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        musicItems = [["category": "Rebelution1", "title":"Be a Winner", "fileName": "Be a Winner.mp3", "isPlaying": (0)],
                      ["category": "Rebelution2", "title":"Believe in yourself", "fileName": "Believe in yourself.mp3", "isPlaying": (0)],
                      ["category": "Rebelution3", "title":"BestTennis Player", "fileName": "BestTennis Player.mp3", "isPlaying": (0)],
                      ["category": "Rebelution4", "title":"Excel in sport", "fileName": "Excel in sport (1).mp3", "isPlaying": (0)],
                      ["category": "Rebelution5", "title":"Exercise in your sleep", "fileName": "Exercise in your sleep.mp3", "isPlaying": (0)],
                      ["category": "Rebelution6", "title":"Get in The zone", "fileName": "Get in The zone.mp3", "isPlaying": (0)],
                      ["category": "Rebelution7", "title":"Improving Lung Capacity", "fileName": "Improving Lung Capacity.mp3", "isPlaying": (0)],
                      ["category": "Rebelution8", "title":"Mental Imagery in Sport", "fileName": "Mental Imagery in Sport.mp3", "isPlaying": (0)],
                      ["category": "Rebelution9", "title":"Mental Toughness", "fileName": "Mental Toughness.mp3", "isPlaying": (0)],
                      ["category": "Rebelution10", "title":"Personal Development and motivation", "fileName": "Personal Development and motivation.mp3", "isPlaying": (0)]];
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicItems.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell") as! MusicTableViewCell
        let item = musicItems.object(at: indexPath.row) as AnyObject
        
        cell.categoryLabel.text = item["category"] as? String
        cell.titleLabel.text = item["title"] as? String
        cell.playPauseBtn.tag = indexPath.row
        cell.configureCellwith(data: item as! [String : Any], and: audioPlayer)
        
        return cell
    }
    
    
    //MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let isPlaying = (musicItems[indexPath.row] as! [String: Any])["isPlaying"] as! NSNumber
        
        if isPlaying.boolValue == true {
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let isPlaying = (musicItems[indexPath.row] as! [String: Any])["isPlaying"] as! NSNumber
        
        if isPlaying.boolValue == false {
            
            if timer != nil {
                timer.invalidate()
            }
        }
    }
    
    
    // MARK: - Action zone
    
    func updateSlider(_ sender: Timer) {
        
        guard let cell = tableView.cellForRow(at: playingIndexPath) else { return }
        
        (cell as! MusicTableViewCell).durationSlider.value = Float(audioPlayer.currentTime)
        let minutes = Int((cell as! MusicTableViewCell).durationSlider.value)/60
        let seconds = Int((cell as! MusicTableViewCell).durationSlider.value) - (minutes * 60);
        let time = String(format: "%02i:%02i", minutes, seconds)
        (cell as! MusicTableViewCell).timerLabel.text = time
    }
    
    @IBAction func didMoveDurationSlider(_ sender: UISlider) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(sender.value)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func didTapPlayButton(_ sender: UIButton) {
        
        let index = sender.tag
        
        var item = musicItems[index] as! [String : Any]
        let indexPath = IndexPath.init(row: index, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! MusicTableViewCell
        
        if audioPlayer != nil {
            
            if audioPlayer.isPlaying {
                
                if playingIndexPath.row == index {
                    
                    audioPlayer.pause()
                    var previousItem = musicItems[playingIndexPath.row] as! [String: Any]
                    previousItem["isPlaying"] = (0)
                    musicItems.replaceObject(at: index, with: previousItem)
                    tableView.reloadRows(at: [playingIndexPath], with: .automatic)
                }
                else {
                    audioPlayer.stop()
                    var previousItem = musicItems[playingIndexPath.row] as! [String: Any]
                    previousItem["isPlaying"] = (0)
                    musicItems.replaceObject(at: playingIndexPath.row, with: previousItem)
                    tableView.reloadRows(at: [playingIndexPath], with: .automatic)
                    
                    item["isPlaying"] =  (1)
                    loadNew(item: item, in: cell, for: indexPath)
                }
            }
            else {
                
                if playingIndexPath.row == index {
                    audioPlayer.play()
                    var previousItem = musicItems[playingIndexPath.row] as! [String: Any]
                    previousItem["isPlaying"] = (1)
                    musicItems.replaceObject(at: index, with: previousItem)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                else {
                    
                    item["isPlaying"] =  (1)
                    loadNew(item: item, in: cell, for: indexPath)
                }
            }
        }
        else {
            item["isPlaying"] =  (1)
            loadNew(item: item, in: cell, for: indexPath)
        }
    }
    
    func loadNew(item: [String: Any], in cell: MusicTableViewCell, for indexPath: IndexPath) {
        
        musicItems.replaceObject(at: indexPath.row, with: item)
        playingIndexPath = indexPath
        
        let filename = item["fileName"] as! String
        let path = Bundle.main.path(forResource: filename, ofType: nil)
        let url = URL(fileURLWithPath: path!)
        
        do {
            audioPlayer = try AVAudioPlayer.init(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch {
            
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func onClickBackButton(_ sender: AnyObject) {
        
        if audioPlayer != nil {
            audioPlayer.stop()
        }
        
        let _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onClickSearchButton(_ sender: AnyObject) {
    }
 
    
}
