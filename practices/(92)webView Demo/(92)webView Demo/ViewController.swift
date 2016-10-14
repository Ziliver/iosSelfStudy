//
//  ViewController.swift
//  (92)webView Demo
//
//  Created by yuanzichao on 12/28/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        var url = NSURL(string: "http://www.google.com")
//        var urlrequest = NSURLRequest(URL: url!)
//        webview.loadRequest(urlrequest)

        var html = "<html><head></head><body><h1>Hello world!</h1></body></body></html>"
        webview.loadHTMLString(html, baseURL: nil)
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

