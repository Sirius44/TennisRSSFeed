//
//  InviteViewController.swift
//  TennisRSSFeedApp
//
//  Created by Adeel Miraj on 24/11/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import MessageUI
import Messages

class InviteViewController: BaseViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    let applicationLink = "https://itunes.apple.com/us/app/moxy-real-connections-here/id933142710?mt=8"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClickSendEmail(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let email = MFMailComposeViewController()
            email.mailComposeDelegate = self
            email.setSubject("Invitation")
            email.setMessageBody(applicationLink, isHTML: false)
            present(email, animated: true, completion: {
                print("Email controller presented")
            })
        }
    }
    
    @IBAction func onClickSendMessage(_ sender: UIButton) {
        
        if MFMessageComposeViewController.canSendText() {
            
            let message = MFMessageComposeViewController()
            message.messageComposeDelegate = self
            message.body = "Do you want to join me in this application?\n" + applicationLink
            
            present(message, animated: true, completion: {
            })
        }
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {
        })
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: {
        })
    }
}
