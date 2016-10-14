//
//  ViewController.swift
//  ShakeAndSwipe(80)
//
//  Created by yuanzichao on 12/26/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
    }

    func swiped(gesture:UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Right:
                println("user swipe right")
            case UISwipeGestureRecognizerDirection.Up:
                println("user swipe Up")
            default:
                break
            }
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake{
            println("user shook the device(control+commmand+z)")
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

