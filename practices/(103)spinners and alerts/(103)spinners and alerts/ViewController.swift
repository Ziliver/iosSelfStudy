//
//  ViewController.swift
//  (103)spinners and alerts
//
//  Created by yuanzichao on 12/29/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
     var activityIndicator = UIActivityIndicatorView()
    
    @IBAction func createAlert(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Hi there", message: "I love you", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
        
        alert.addAction(UIAlertAction(title: "OK, I hate you!", style:.Default, handler: {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "destructive", style: UIAlertActionStyle.Destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "style of cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }

    @IBAction func pause(sender: AnyObject) {
        
        /*stop touch screen*/

//        UIApplication.sharedApplication().beginIgnoringInteractionEvents()

/*activity indicator*/
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }
    
    
    @IBAction func restore(sender: AnyObject) {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
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

