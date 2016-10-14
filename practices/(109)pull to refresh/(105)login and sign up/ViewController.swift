//
//  ViewController.swift
//  (105)login and sign up
//
//  Created by yuanzichao on 12/29/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator = UIActivityIndicatorView()
    
    var signUpActive = true
    
    func displayErrorByAlert(title:NSString,error:NSString){
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
                action in
                    self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
           self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    
    @IBOutlet weak var UseTheFormLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var alreadySignedUp: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func login(sender: AnyObject) {
        
        if signUpActive == true{
            UseTheFormLabel.text = "Please use the form below to login"
            signUpButton.setTitle("Login", forState: UIControlState.Normal)
            alreadySignedUp.text = "Not signed up yet?"
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signUpActive = false
        }else{
            UseTheFormLabel.text = "Use the form below to sign up"
            signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            alreadySignedUp.text = "Already registered"
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            signUpActive = true
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        
        
        var error = ""
        if userName.text == "" || Password.text == ""{
            error = "\nPlease enter a username and a password"
        }
        
        if error != "" {
            
            displayErrorByAlert("Sorry", error: error)
            
        }else {
            
//bring an activity indicator
                
                activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                
//stop user interaction
                
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            
        if signUpActive == true{
//signup
        
            var user = PFUser()
            user.username = userName.text
            user.password = Password.text
user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, signUpError: NSError!) -> Void in
                

//stop activity indicator
            self.activityIndicator.stopAnimating()
                
//resume user interaction
            UIApplication.sharedApplication().endIgnoringInteractionEvents()                
             

                if signUpError == nil {
                    // Hooray! Let them use the app now.
                   
                     self.displayErrorByAlert("Wonderful! You have gotten an account!", error:"succeed")
                } else {
                    if let errorString = signUpError.userInfo?["error"] as? NSString{
                        error = errorString
                    }else {
                        error = "plese try again later"
                    }
                    self.displayErrorByAlert("Could not sign up", error: error)
                    
                }
            }
        }
// login (signUpActive == false)
        else{
            PFUser.logInWithUsernameInBackground(userName.text, password:Password.text) {
                (user: PFUser!, signUpError: NSError!) -> Void in
//stop activity indicator
            self.activityIndicator.stopAnimating()
                
//resume user interaction
            UIApplication.sharedApplication().endIgnoringInteractionEvents()                
             

                if user != nil {
                    self.displayErrorByAlert("Brilliant! You have logged in!", error:"succeed")
                } else {
                    if let errorString = signUpError.userInfo?["error"] as? NSString{
                        error = errorString
                    }else {
                        error = "plese try again later"
                    }
                    self.displayErrorByAlert("Could not login", error: error)
                    
                }
            }
        }
        
    }
}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        println(PFUser.currentUser())
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("JumpToUserTable", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

