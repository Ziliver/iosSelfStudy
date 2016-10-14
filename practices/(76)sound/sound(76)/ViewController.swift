//
//  ViewController.swift
//  sound(76)
//
//  Created by yuanzichao on 12/25/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()

    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
        
    }
    @IBAction func volume(sender: AnyObject) {
        player.volume = 0.25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource("kissTheRain", ofType:"mp3")!)
        var error:NSError? = nil
        
        player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation), error: &error)
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

