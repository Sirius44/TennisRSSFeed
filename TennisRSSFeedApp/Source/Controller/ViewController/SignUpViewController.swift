//
//  SignUpViewController.swift
//  TennisRSSFeedApp
//
//  Created by Adeel Miraj on 26/11/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import ARSLineProgress
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var displayNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var signupBtn: UIButton!
    
    let dbRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLayerForView(aView: displayNameView)
        setupLayerForView(aView: emailView)
        setupLayerForView(aView: passwordView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLayerForView(aView: UIView) {
        let layer = aView.layer
        layer.borderWidth = 2.0
//        let color = UIColor.init(colorLiteralRed: 82.0/255.0, green: 214.0/255.0, blue: 129.0/255.0, alpha: 1)
        layer.borderColor = UIColor.white.cgColor// color.cgColor
    }
    
    
    @IBAction func onClickBtnSignup(_ sender: UIButton) {
        
        if (displayNameField.text?.isEmpty)! || (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            showAlertWith("Missing Input", and: "All fields are mandatory. Please fill in all the fields.")
            return
        }
        
        sender.isEnabled = false
        ARSLineProgress.show()
        
        FIRAuth.auth()?.createUser(withEmail: emailField.text!,
                                   password: passwordField.text!,
                                   completion: { (user, error) in
                                    
                                    if error == nil {
                                        FIRAuth.auth()?.signIn(withEmail: self.emailField.text!,
                                                               password: self.passwordField.text!,
                                                               completion: { (user, error) in
                                                                
                                                                if error == nil {
                                                                    
                                                                    let detailsRef = self.dbRef.child("user-details")
                                                                    let userRef = detailsRef.child((user?.uid)!)
                                                                    userRef.setValue(["city": "xyz"])
                                                                    user?.city = "xyz"
                                                                    let updateRequest = user?.profileChangeRequest()
                                                                    updateRequest?.displayName = self.displayNameField.text
                                                                    updateRequest?.commitChanges(completion: { (error) in
                                                                        
                                                                        ARSLineProgress.hide()
                                                                        
                                                                        if error == nil {
                                                                            self.gotoMenuScreen()
                                                                        }
                                                                        else {
                                                                            self.showAlertWith("Error", and: (error?.localizedDescription)!)
                                                                        }
                                                                    })
                                                                }
                                                                else {
                                                                    self.showAlertWith("Error", and: (error?.localizedDescription)!)
                                                                    sender.isEnabled = true
                                                                    ARSLineProgress.hide()
                                                                }
                                        })
                                    }
                                    else {
                                        self.showAlertWith("Error", and: (error?.localizedDescription)!)
                                        sender.isEnabled = true
                                        ARSLineProgress.hide()
                                    }
        })
    }
    
    func gotoMenuScreen() {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "mainview") as UIViewController
        present(viewController, animated: true, completion: {
            UIApplication.shared.keyWindow?.rootViewController = viewController
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == displayNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
            onClickBtnSignup(signupBtn)
        }
        
        return true
    }

}

extension UIViewController {
    
    func showAlertWith(_ title: String, and message: String) {
        let alertController = UIAlertController.init(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "OK",
                                               style: .cancel,
                                               handler: { action in
        })
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: {
        })
    }
}

