//
//  LoginViewController.swift
//  TennisRSSFeedApp
//
//  Created by admin on 10/19/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import ARSLineProgress
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {//, AIAuthenticationDelegate {

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
//    @IBOutlet weak var btnEmail: UIButton!
//    @IBOutlet weak var btnPassword: UIButton!
    
    let ref = FIRDatabase.database().reference()
    
    @IBAction func OnClickedBtnLogin(_ sender: AnyObject) {
        
        if (txtEmail.text?.isEmpty)! {
            showAlertWith("Email Missing", and: "Email field cannot be empty. Please enter a valid email address.")
            return
        }
        else if (txtPassword.text?.isEmpty)! {
            showAlertWith("Password Missing", and: "Password field cannot be empty. Please enter the password.")
            return
        }
        
        btnLogin.isEnabled = false
        ARSLineProgress.show()
        
        FIRAuth.auth()?.signIn(withEmail: txtEmail.text!,
                               password: txtPassword.text!,
                               completion: { (user, error) in
                                
                                ARSLineProgress.hide()
                                
                                if error == nil {
                                    self.gotoMenuScreen()
                                }
                                else {
                                    self.showAlertWith("Error", and: (error?.localizedDescription)!)
                                    self.btnLogin.isEnabled = true
                                }
        })
    }
    
    @IBAction func onClickBtnSignup(_ sender: UIButton) {
    }
    
    func gotoMenuScreen(){
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "mainview") as UIViewController
        present(viewController, animated: true, completion: {
            UIApplication.shared.keyWindow?.rootViewController = viewController
        })
    }
    
    func setupLayerForView(aView: UIView) {
        let layer = aView.layer
        layer.cornerRadius = 24
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.white.cgColor
    }
    
//    func LoadUI() {
//        
//        self.view.backgroundColor = UIColor(red: 82/255.0, green: 214/255.0, blue: 129/255.0, alpha: 1.0)
//        
//        btnEmail.backgroundColor = UIColor.clear
//        btnEmail.layer.cornerRadius = 24
//        btnEmail.layer.borderWidth = 2.0
//        btnEmail.layer.borderColor = UIColor.white.cgColor
//        
//        btnPassword.backgroundColor = UIColor.clear
//        btnPassword.layer.cornerRadius = 24
//        btnPassword.layer.borderWidth = 2.0
//        btnPassword.layer.borderColor = UIColor.white.cgColor
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        LoadUI()
        // Do any additional setup after loading the view.
        setupLayerForView(aView: emailView)
        setupLayerForView(aView: passwordView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
            OnClickedBtnLogin(btnLogin)
        }
        
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - AWS Login Delegate
    /*
    func requestDidSucceed(_ apiResult: APIResult!) {
        if apiResult.api == API.authorizeUser {
            AIMobileLib.getAccessToken(forScopes: ["profile"], withOverrideParams: nil, delegate: self)
        } else if apiResult.api == API.getAccessToken {
            
            // Handle Login logic for custom sign-in here.
            let alertController = UIAlertController(title: "Alert", message:"Success Login!", preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
            alertController.addAction(doneAction)
            present(alertController, animated: true, completion: nil)
            
            gotoMain();
        }
    }
    func requestDidFail(_ errorResponse: APIError!) {
        //self.errorAlert("Error logging in with Amazon: " + errorResponse.description)
        
        let alertController = UIAlertController(title: "Alert", message:"Failed Login!", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
        
        // AWSTask(result: nil).continueWithBlock(self.completionHandler)
    }
*/
}
