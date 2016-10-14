//
//  ViewController.swift
//  (97)Installgram
//
//  Created by yuanzichao on 12/29/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        practice Parse
//set object
//        
//        
//        Parse.setApplicationId("Spusmj2teWCOSq2iOBQPLNeH7EcucW4IgxLryVFF", clientKey: "enQ6zNlpglpUmivPEVWguaeSzPfDEcMDwgvwIhYA")
//        var score = PFObject(className: "score")
//        score.setObject("rob", forKey: "name")
//        score.setObject(99, forKey: "number")
//        
//        score.saveInBackgroundWithBlock({
//            (success:Bool!, error:NSError!) -> Void in
//            if (success == true){
//                println("success with object ID: \(score.objectId)")
//            }else{
//                println(error)
//            }
//        })
        
        
//        
////query
        Parse.setApplicationId("Spusmj2teWCOSq2iOBQPLNeH7EcucW4IgxLryVFF", clientKey: "enQ6zNlpglpUmivPEVWguaeSzPfDEcMDwgvwIhYA")

        var query = PFQuery(className: "score")
        query.getObjectInBackgroundWithId("Yaek55fl5n", block: {
            (score:PFObject!,error:NSError!) -> Void in
            if error == nil{
// read object
//                println(score)
//                println(score.objectForKey("name"))
//                println(score.objectForKey("name") as NSString)
//                println(score["name"])
//                println(score["name"] as NSString)
                
// update object
                score["name"] = "yuan"
                score["number"] = 1231
                score["xad"] = 131312313
                score.save()
                
//delete object
//                score.delete()

                
//for more look at https://www.parse.com/docs/ios_guide#objects-deleting/iOS
                
            }else{
                println(error)
            }
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

