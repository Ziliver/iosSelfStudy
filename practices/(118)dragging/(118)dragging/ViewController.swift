//
//  ViewController.swift
//  (118)dragging
//
//  Created by yuanzichao on 1/2/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var xFromcenter: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var label: UILabel = UILabel(frame: CGRectMake(self.view.bounds.width/2-100,self.view.bounds.height/2-50,200,100))
        label.text = "drag me"
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        
        var gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        label.addGestureRecognizer(gesture)
        
        label.userInteractionEnabled = true
        
        
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
        
        if labelm.center.x < 100{
            println("not chosen")
        }else if labelm.center.x > self.view.bounds.width - 100{
            println("chosen")
        }
        
        if gesture.state == UIGestureRecognizerState.Ended {
            labelm.center = self.view.center
            rotate = CGAffineTransformMakeRotation(0)
            xFromcenter = 0
            stretch = CGAffineTransformScale(rotate, 1, 1)
            labelm.transform = stretch
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

