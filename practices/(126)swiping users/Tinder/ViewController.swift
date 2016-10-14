//
//  ViewController.swift
//  (115)tinder
//
//  Created by yuanzichao on 1/2/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var loginUnsuccessful: UILabel!
    
    @IBAction func loginFacebook(sender: AnyObject) {
        
        var permissions = ["public_profile"]
        
        self.loginUnsuccessful.alpha = 0
        
        
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                self.loginUnsuccessful.alpha = 1
            } else if user.isNew == true {
                NSLog("User signed up and logged in through Facebook!")
                println("owrk")
                
                self.performSegueWithIdentifier("signedUp", sender: self)
            } else {
                NSLog("User logged in through Facebook!")
                println(user.isNew)
            }
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //        var push = PFPush()
        //        push.setMessage("This is a test")
        //        push.sendPushInBackgroundWithBlock({
        //            (isSuccessful:Bool!, error:NSError!) -> Void in
        //
        //            println(isSuccessful)
        //
        //        })
        if PFUser.currentUser() != nil{
            println("user logged in")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

