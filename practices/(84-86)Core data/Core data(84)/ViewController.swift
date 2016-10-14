//
//  ViewController.swift
//  Core data(84)
//
//  Created by yuanzichao on 12/28/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        //
        
// How to add
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        newUser.setValue("yuan", forKey: "username")
        
        newUser.setValue("pass", forKey: "password")
        context.save(nil)

                    ///another user
                    
                        var newUser2 = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
                        
                        newUser2.setValue("zichao", forKey: "username")
                        
                        newUser2.setValue("pass2", forKey: "password")
///update user

    var newUser3 = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
    
    newUser3.setValue("Tom", forKey: "username")
    
    newUser3.setValue("pass9", forKey: "password")
    newUser3.setValue("pass99", forKey: "password")

        
        
        context.save(nil)
        
        var request = NSFetchRequest(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        var result = context.executeFetchRequest(request, error: nil)
        
//        println(result)
        
        
//How to delete
        for resultt:AnyObject in result!{
            if let user = resultt.valueForKey("username") as? String{
                
                println(user)
                
                if user == "zichao" || user == "yuan"{
                    
                    context.deleteObject(resultt as NSManagedObject)
                    
                    println(user + " has been deleted")
            }
        }
            context.save(nil)
            
    }
        
//How to check (predicate)
        
        request.predicate = NSPredicate(format: "username = %@", "Tom")
        var result2 = context.executeFetchRequest(request, error: nil)

        println(result2)
//update Tom
        for resultt:AnyObject in result2!{
            if let user = resultt.valueForKey("username") as? String{
                
                println(user)
                
                if user == "Tom"{
                    
                    resultt.setValue("pass6", forKey: "password")
                    if let p = resultt.password! {
                        println(p)
                    }
                    context.save(nil)

                }
            }
    }
        
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

