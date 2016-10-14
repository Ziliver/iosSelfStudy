//
//  ViewController.swift
//  (147)SnapChat
//
//  Created by yuanzichao on 1/8/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var SignIn: UIButton!
    
    @IBAction func SignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(username.text, password:"mypass") {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {

            println("logged in")
            
            } else {
            
                    var user = PFUser()
                    user.username = self.username.text
                    user.password = "myPassword"
                    
                    user.signUpInBackgroundWithBlock {
                        (succeeded: Bool!, error: NSError!) -> Void in
                        if error == nil {
                            
                            println("signed up")
                            
                        } else {
                            println("error")
                            println(error)
                            
                        }
                }
                
                
            }
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

