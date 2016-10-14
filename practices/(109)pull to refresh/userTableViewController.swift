//
//  userTableViewController.swift
//  (105)login and sign up
//
//  Created by yuanzichao on 12/31/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit


class userTableViewController: UITableViewController {
    var  refresher = UIRefreshControl()
    var userList = [""]
    var following = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUsers()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents:UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
    }
    
    func updateUsers(){
        var query = PFUser.query()
        query.findObjectsInBackgroundWithBlock({
            (objects:[AnyObject]!,error:NSError!) -> Void in
            
            self.userList.removeAll(keepCapacity: true)
            
            for object in objects{
                var user : PFUser = object as PFUser
                var isFollowing: Bool
                
                if user.username != PFUser.currentUser().username{
                self.userList.append(user.username)
                    
                    isFollowing = false
                    var query = PFQuery(className:"followers")
                    query.whereKey("following", equalTo:user.username)
                    query.whereKey("follower", equalTo: PFUser.currentUser().username)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        if error == nil {
                            for object in objects {
                                isFollowing = true
                            }
                        }
                    self.following.append(isFollowing)
                        
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }
    
    func refresh(){
        println("it works")
        updateUsers()
        self.refresher.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        if following.count > indexPath.row{
            if following[indexPath.row]{
                                                                                            //warning:I think this part doesn't work
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
        }
        cell.textLabel?.text = userList[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark{
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className:"followers")
            query.whereKey("following", equalTo:cell.textLabel?.text)
            query.whereKey("follower", equalTo: PFUser.currentUser().username)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    for object in objects {
                        object.delete()
                    }
                } else {
                    println(error)
                }
            }
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            var follow = PFObject(className: "followers")
            follow["following"] = cell.textLabel?.text
            follow["follower"] = PFUser.currentUser().username
            follow.save()
            
        }
    }
    
    
}
