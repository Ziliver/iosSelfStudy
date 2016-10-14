//
//  FeedViewController.swift
//  (105)login and sign up
//
//  Created by yuanzichao on 12/31/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {

    var titles = [String]()
    var usernames = [String]()
    var images = [UIImage]()
    var imageFiles = [PFFile]()
    
    override  func viewDidLoad() {
       
        super.viewDidLoad()
        
        var FollowedUserquery = PFQuery(className:"followers")
        FollowedUserquery.whereKey("follower", equalTo:PFUser.currentUser().username)
        FollowedUserquery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                var followedUser = ""
                
                for object in objects {
                    followedUser = object["following"] as String
                    
                    var query = PFQuery(className:"Post")
                    query.whereKey("username", equalTo:followedUser)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        if error == nil {
                            // The find succeeded.
                            println("Successfully retrieved \(objects.count) scores.")
                            // Do something with the found objects
                            
                            for object in objects {
                                self.titles.append(object["title"] as String)
                                self.usernames.append(object["username"] as String)
                                self.imageFiles.append(object["imageFile"] as PFFile )
                                self.tableView.reloadData()

                            }
                        } else {
                            println(error)
                        }
                    }                    
                }
            } else {
                println(error)
            }
        }

        

       
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var myCell:Cell = self.tableView.dequeueReusableCellWithIdentifier("myCell") as Cell
        myCell.title.text = titles[indexPath.row]
        myCell.username.text = usernames[indexPath.row]
       
        imageFiles[indexPath.row].getDataInBackgroundWithBlock({
            (imageData:NSData!,error:NSError!) -> Void in
            if error == nil {
                let image = UIImage(data: imageData)
                myCell.postedImage.image = image
            }else{
                println(error)
            }
        })
        
        return myCell
    }
}
