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
        println("hi y")
        var i = 10.0
        var lat = 37.335175
        var lon = -122.032551

        PFGeoPoint.geoPointForCurrentLocationInBackground { (geopoint: PFGeoPoint!, error:  NSError!) -> Void in
            println("hi")
            if error == nil {
                println(geopoint)
                var user = PFUser.currentUser()
                user["location"] = geopoint
                user.save()
            
                println("asdff")
            }else{
                println(error)
            }
        }

         func addUser(urlString:String){
                    var newUser = PFUser.currentUser()
                    let url = NSURL(string: urlString)
                    let urlRequest = NSURLRequest(URL: url!)
                    NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { response, data, error  in
                        newUser["image"] = data
                        newUser["gender"] = "female"

                        lat += i
                        lon += i
                        var location = PFGeoPoint(latitude: lat, longitude: lon)
                        newUser["location"] = location
                        newUser["username"] = "\(i)"
                        newUser["password"] = "passzz"
                        newUser.save()
                    }
                }
       addUser("http://s3.amazonaws.com/readers/2010/12/07/3186885154021fda16b1_1.jpg")
//
       

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
