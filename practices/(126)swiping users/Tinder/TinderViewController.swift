//
//  TinderViewController.swift
//  (115)tinder
//
//  Created by yuanzichao on 1/3/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import UIKit

class TinderViewController: UIViewController {
    var xFromcenter: CGFloat = 0
    var users = [String]()
    var userImages = [NSData]()
    var currentUser = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("hi y")
        var i = 1.0
        var lat = 37.335175
        var lon = -122.032551
        
        PFGeoPoint.geoPointForCurrentLocationInBackground { (geopoint: PFGeoPoint!, error:  NSError!) -> Void in
            println("hi")
            if error == nil {
                println(geopoint)
                var user = PFUser.currentUser()
                user["location"] = geopoint
                
                var query = PFUser.query()
                query.whereKey("location", nearGeoPoint:geopoint)
                
//cannot do it in that way
//                query.whereKey("username", notEqualTo: PFUser.currentUser().username)
//                query.whereKey("gender", equalTo: PFUser.currentUser()["interestedIn"])
                query.limit = 10
                
//                var accepted = PFUser.currentUser()["accepted"] as [String]
//                var rejected = PFUser.currentUser()["rejected"] as [String]
                
                query.findObjectsInBackgroundWithBlock({ (users, error) -> Void in
                    for user in users{
                        
//not working in choosing
                        var gender1 = user["gender"] as? NSString
                        var gender2 = PFUser.currentUser()["interestedIn"] as? NSString
                      
//                        if gender1 == "female" && PFUser.currentUser().username != user.username && !contains(accepted,user.username) && !contains(rejected,user.username){
                        
                        self.users.append(user.username)
                        self.userImages.append(user["image"] as NSData)
                            
//                        }

                    }
                    //from dragging
        
                        var userImage = UIImageView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
                        userImage.image = UIImage(data: self.userImages[0])
                        userImage.contentMode = UIViewContentMode.ScaleAspectFit
                        self.view.addSubview(userImage)

                        
                        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
                        userImage.addGestureRecognizer(gesture)
                        
                        userImage.userInteractionEnabled = true
                })
                
                user.save()
                
                
                
                
            }
        }
////my code(not working)
//        func addUser(urlString:String){
//            var newUser = PFUser()
//            let url = NSURL(string: urlString)
//            let urlRequest = NSURLRequest(URL: url!)
//            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { response, data, error  in
//                newUser["image"] = data
//                newUser["gender"] = "female"
//                
//                lat += i
//                lon += i
//                var location = PFGeoPoint(latitude: lat, longitude: lon)
//                newUser["location"] = location
//                newUser["username"] = "\(i)"
////                newUser["password"] = "passzz"
//                newUser.save()
//            }
//        }
        
////sample code (working)
//        func addUser(urlString:String) {
//            
//            var newUser = PFUser()
//            
//            let url = NSURL(string: urlString)
//            
//            let urlRequest = NSURLRequest(URL: url!)
//            
//            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
//                response, data, error in
//                
//                newUser["image"] = data
//                
//                newUser["gender"] = "female"
//                
//                var lat = Double(37 + i)
//                
//                var lon = Double(-122 + i)
//                
//                i = i + 10
//                
//                var location = PFGeoPoint(latitude: lat, longitude: lon)
//                
//                newUser["location"] = location
//                
//                newUser.username = "\(i)"
//                
//                newUser.password = "password"
//                
//                newUser.signUp()
//                
//                
//            })

//        addUser("http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=44643840")
//        addUser("http://static.comicvine.com/uploads/square_small/0/2617/103863-63963-torongo-leela.JPG")
//        addUser("http://www.scrapwallpaper.com/wp-content/uploads/2014/08/female-cartoon-characters-pictures-6.jpg")
//        addUser("http://diaryofalagosmumblog.files.wordpress.com/2011/11/smurfette-scaled500.gif")
//        addUser("http://i263.photobucket.com/albums/ii139/whatgloom/janejetson.jpg")
//
//       addUser("http://s3.amazonaws.com/readers/2010/12/07/3186885154021fda16b1_1.jpg")
//


        
            }
    func wasDragged(gesture:UIPanGestureRecognizer){
            
            
            let translation = gesture.translationInView(self.view)
            var labelm = gesture.view!
            labelm.center = CGPoint(x: labelm.center.x + translation.x, y: labelm.center.y + translation.y)
            
            xFromcenter += translation.x
            var rotate:CGAffineTransform = CGAffineTransformMakeRotation(xFromcenter/200)
            //        labelm.transform = rotate
            println(xFromcenter)
            
            var scale = min(100/abs(xFromcenter), 1)
            var stretch:CGAffineTransform = CGAffineTransformScale(rotate, scale, scale)
            labelm.transform  = stretch
            
            
            gesture.setTranslation(CGPointZero, inView: self.view)
            
        
            if gesture.state == UIGestureRecognizerState.Ended {
                if labelm.center.x < 100{
                    println("not chosen")
                    PFUser.currentUser().addUniqueObject(self.users[self.currentUser], forKey:"rejected")
                    
                    PFUser.currentUser().save()
                    
                    self.currentUser++

                }else if labelm.center.x > self.view.bounds.width - 100{
                    println("chosen")
                    
                    PFUser.currentUser().addUniqueObject(self.users[self.currentUser], forKey:"accepted")

                    PFUser.currentUser().save()
                    self.currentUser++

                }

                labelm.removeFromSuperview()
                
                
                if self.currentUser<self.userImages.count{
                    
                var userImage = UIImageView(frame: CGRectMake(0,0,self.view.frame.width,self.view.frame.height))
                userImage.image = UIImage(data: self.userImages[self.currentUser])
                userImage.contentMode = UIViewContentMode.ScaleAspectFit
                self.view.addSubview(userImage)
                var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
                userImage.addGestureRecognizer(gesture)
                
                userImage.userInteractionEnabled = true
                xFromcenter = 0
                }
                else{
                    println("running out of users"  )
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
