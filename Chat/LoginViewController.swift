//
//  LoginViewController.swift
//  Chat
//
//  Created by Timothy Lee on 9/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(
            usernameField.text, password: passwordField.text) { (user: PFUser!, error: NSError!) -> Void in
            self.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackgroundWithBlock { (result: Bool, error: NSError!) -> Void in
            self.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }
}
