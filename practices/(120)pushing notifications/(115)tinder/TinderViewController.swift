//
//  TinderViewController.swift
//  (115)tinder
//
//  Created by yuanzichao on 1/3/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import UIKit

class TinderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi y")
        
        PFGeoPoint.geoPointForCurrentLocationInBackground { (geopoint: PFGeoPoint!, error:  NSError!) -> Void in
            print("hi")
            if error == nil {
                print(geopoint)
            }else{
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
