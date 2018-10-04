//
//  ViewController.swift
//  instagram
//
//  Created by Junghoon Lee on 8/8/18.
//  Copyright © 2018 Junghoon Lee. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    var signupModeActive = true
    var activityIndicator = ActivityIndicator()
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var switchLoginModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func signup() {
        let user = PFUser()
        user.email = email.text
        user.password = password.text
        user.username = email.text
        user.signUpInBackground { (success, error) in
            self.activityIndicator.stopActivityIndicator(uiView: self)
            if let error = error {
                self.displayAlert(title: "Could not sign you up", message: error.localizedDescription)
            } else {
                print("sign up successful with user \(user.email!)")
            }
        }
    }
    
    
    func login() {
        PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) { (user, error) in
            self.activityIndicator.stopActivityIndicator(uiView: self)
            if user != nil {
                print("Login successful")
            } else {
                var errorText = "Unknown error: please try again"
                
                if let error = error {
                    errorText = error.localizedDescription
                }
                self.displayAlert(title: "Could not log you in", message: errorText)
            }
        }
    }

    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if email.text == "" && password.text == "" {
            displayAlert(title: "Don't leave a blank", message: "Please enter both email and password")
            
        } else if email.text == "" || password.text == ""  {
            displayAlert(title: "Don't leave a blank", message: "Please enter a valid email or password")
            
        } else {
            activityIndicator.startActivityIndicator(uiView: self)
            if signupModeActive {
                print("Processing sign up ...")
                signup()
            } else {
                print("Processing log in ...")
                login()
            }
        }
        
    }
    
    
    @IBAction func switchLoginModeButtonPressed(_ sender: Any) {
        if signupModeActive {
            signupModeActive = false
            submitButton.setTitle("Log In", for: [])
            switchLoginModeButton.setTitle("Sign Up", for: [])
        } else {
            signupModeActive = true
            submitButton.setTitle("Sign Up", for: [])
            switchLoginModeButton.setTitle("Log In", for: [])
        }
    }
}

