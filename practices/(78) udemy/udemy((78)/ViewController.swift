//
//  ViewController.swift
//  udemy((78)
//
//  Created by yuanzichao on 12/26/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    @IBAction func play(sender: AnyObject) {
        player.play()
    }
    @IBAction func stop(sender: AnyObject) {
    
        player.stop()
        player.currentTime = 0
    }
    
    @IBAction func pause(sender: AnyObject) {
    
        player.pause()
    }
    @IBOutlet weak var volume: UISlider!
    @IBAction func volume(sender: AnyObject) {
        player.volume = volume.value
    }
    var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource("kissTheRain", ofType: "mp3")!)
        var error:NSError? = nil
//        player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation), error: &error)
        do{
        try player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation as String)!)
        }catch{
            
        }
//        player.play()
        
    player.enableRate = true
    player.rate = 2
    print(player.deviceCurrentTime)
        
        var s = AVVideoComposition(propertiesOfAsset: AVAsset(URL:  NSURL(string: fileLocation as String)!))
        print(s.frameDuration)
        print(s.renderScale)
        print(s.renderSize)
        var instruction = s.instructions
        print(instruction.description)
        print(s.customVideoCompositorClass)
        MPMoviePlayerController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

