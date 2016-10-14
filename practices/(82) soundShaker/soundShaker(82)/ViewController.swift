//
//  ViewController.swift
//  soundShaker(82)
//
//  Created by yuanzichao on 12/26/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    var musics = ["LoveyDovey","kissTheRain","littleLove"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var randomNumber = Int(arc4random_uniform(UInt32(musics.count)))
        var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(musics[randomNumber], ofType: "mp3")!)
        var error:NSError? = nil
        player = AVAudioPlayer(contentsOfURL:NSURL(string: fileLocation), error: &error)
        
    }

    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake{
            if player.playing == true {
                player.stop()
                player.currentTime = 0}
            
//            println("user shook")
             var randomNumber = Int(arc4random_uniform(UInt32(musics.count)))
        var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource(musics[randomNumber], ofType: "mp3")!)
        var error:NSError? = nil
        
        player = AVAudioPlayer(contentsOfURL:NSURL(string: fileLocation), error: &error)
    
                player.play()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

