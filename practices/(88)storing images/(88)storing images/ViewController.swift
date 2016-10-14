//
//  ViewController.swift
//  (88)storing images
//
//  Created by yuanzichao on 12/28/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        
//        var url = NSURL (string: "https://www.google.com/images/srpr/logo11w.png")
//        var urlrequest = NSURLRequest(URL: url!)
//        NSURLConnection.sendAsynchronousRequest(urlrequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
//            response, data, error in
//            if error != nil{
//                println("there are some errors")
//            }
//            else{
//                var image = UIImage(data: data)
////                self.imageview.image = image
//         var documents_dierctory: String
//        
//        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//        if paths.count>0{
//            documents_dierctory = paths[0] as String
//            var savePath = documents_dierctory + "/googleView.jpg"
//            NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
//            self.imageview.image = UIImage(named: savePath)
//        }
//            }
//        })
//        
//   
        /*after running the above code to save the data, we can use it as below*/
       
//        var documents_dierctory: String
//        
//        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//        if paths.count>0{
//            documents_dierctory = paths[0] as String
//            var savePath = documents_dierctory + "/googleView.jpg"
//            self.imageview.image = UIImage(named: savePath)
//            
//        }
        
       
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//         Dispose of any resources that can be recreated.
    }


}

