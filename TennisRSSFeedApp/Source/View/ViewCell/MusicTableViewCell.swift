//
//  MusicTableViewCell.swift
//  TennisRSSFeedApp
//
//  Created by RichMan on 11/16/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import AVFoundation

class MusicTableViewCell: UITableViewCell, AVAudioPlayerDelegate {

    @IBOutlet weak var playImgView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var songTimeLengthLabel: UILabel!
    @IBOutlet weak var toolSubview: UIView!
    @IBOutlet weak var loveNumberLabel: UILabel!
    @IBOutlet weak var loveBtn: UIButton!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var playListBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var regaeBtn: UIButton!
    @IBOutlet weak var musicTimeBarSubView: UIView!
    @IBOutlet weak var backawardBtn: UIButton!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var cellSubView: UIView!
    
    var cellPath: IndexPath!
//    var audioPlayer: AVAudioPlayer!
    var audioUrl: URL!
//    var timer: Timer!
    //var isPlaying
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        musicTimeBarSubView.isHidden = true
        setBoarderOfView(ofView: regaeBtn, borderWidth: 0.5, borderColor: UIColor.clear, cornerRadius: 5.0)
        setBoarderOfView(ofView: loveBtn, borderWidth: 0.5, borderColor: UIColor.black, cornerRadius: 5.0)
        setBoarderOfView(ofView: playListBtn, borderWidth: 0.5, borderColor: UIColor.black, cornerRadius: 5.0)
        setBoarderOfView(ofView: shareBtn, borderWidth: 0.5, borderColor: UIColor.black, cornerRadius: 5.0)
        setBoarderOfView(ofView: cellSubView, borderWidth: 0.5, borderColor: UIColor.clear, cornerRadius: 5.0)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUrl(url: URL) {
        self.audioUrl = url
        
//        if self.audioPlayer.isPlaying {
//            
//        }
//        else {
//            do {
//                try audioPlayer = AVAudioPlayer(contentsOf: audioUrl)
//            } catch {
//                
//            }
//            durationSlider.maximumValue = Float(audioPlayer.duration)
//            let minutes = Int(durationSlider.maximumValue)/60
//            let seconds = Int(durationSlider.maximumValue) - (minutes * 60);
//            let time = String(format: "%02i:%02i", minutes, seconds)
//            songTimeLengthLabel.text = time
//        }
    }
    
    func configureCellwith(data: [String: Any], and player: AVAudioPlayer?) {
        
//        self.cellPath = indexPath
        
        let isPlaying = data["isPlaying"] as! NSNumber
        
        if !isPlaying.boolValue {
            
            let filename = data["fileName"] as! String
            let path = Bundle.main.path(forResource: filename, ofType: nil)
            let url = URL(fileURLWithPath: path!)
            
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                durationSlider.maximumValue = Float(audioPlayer.duration)
                let minutes = Int(durationSlider.maximumValue)/60
                let seconds = Int(durationSlider.maximumValue) - (minutes * 60);
                let time = String(format: "%02i:%02i", minutes, seconds)
                songTimeLengthLabel.text = time
                
            } catch {
                durationSlider.maximumValue = 0
            }
            
            playImgView.isHighlighted = false
            musicTimeBarSubView.isHidden = true
            toolSubview.isHidden = false
            
            durationSlider.value = 0// Float((player?.currentTime)!)
//            audioPlayer.play()
//            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        }
        else {
            
            durationSlider.maximumValue = Float((player?.duration)!)
            let minutes = Int(durationSlider.maximumValue)/60
            let seconds = Int(durationSlider.maximumValue) - (minutes * 60);
            let time = String(format: "%02i:%02i", minutes, seconds)
            songTimeLengthLabel.text = time
            durationSlider.value = Float((player?.currentTime)!)
            
            playImgView.isHighlighted = true
            musicTimeBarSubView.isHidden = false
            toolSubview.isHidden = true
            
//            audioPlayer.stop()
//            timer.invalidate()
        }
        
        
    }
    
    @IBAction func tappedBackawardButton(_ sender: UIButton) {
    }
    
    @IBAction func tappedForwardButton(_ sender: AnyObject) {
    }
    
    @IBAction func tappedPlayButton(_ sender: UIButton) {
        
        if !playImgView.isHighlighted {
            playImgView.isHighlighted = true
            musicTimeBarSubView.isHidden = false
            toolSubview.isHidden = true
//            audioPlayer.play()
//            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        } else {
            playImgView.isHighlighted = false
            musicTimeBarSubView.isHidden = true
            toolSubview.isHidden = false
//            audioPlayer.stop()
//            timer.invalidate()
        }
    }
   
    @IBAction func changedAudioTIme(_ sender: UISlider) {
//        audioPlayer.stop()
//        audioPlayer.currentTime = TimeInterval(durationSlider.value)
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
    }
    
    func updateSlider() {
//        durationSlider.value = Float(audioPlayer.currentTime)
        let minutes = Int(durationSlider.value)/60
        let seconds = Int(durationSlider.value) - (minutes * 60);
        let time = String(format: "%02i:%02i", minutes, seconds)
        timerLabel.text = time
    }
    
    func setBoarderOfView(ofView: UIView, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        ofView.layer.borderColor = borderColor.cgColor
        ofView.layer.cornerRadius = cornerRadius
        ofView.layer.borderWidth = borderWidth
    }
}
