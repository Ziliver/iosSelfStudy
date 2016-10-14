//
//  ViewController.swift
//  (90)Json Data
//
//  Created by yuanzichao on 12/28/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pathurl = "http://www.telize.com/geoip"
        let url = NSURL(string: pathurl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data,response,error -> Void in
            if error != nil{
                println(error)
            }else
            {
//                println(data)
                let JasonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                println(JasonResult)
                
                println(JasonResult["asn"])
                if let x = JasonResult["asn"]{ println(x)}
                
            }
        })
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

