//
//  GameScene.swift
//  (135)adding and animating sprite
//
//  Created by yuanzichao on 1/6/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
    var background = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
// add backgrounds
        var bgTexture = SKTexture(imageNamed: "bg.png")
        
        var movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var movebgReplace = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var movebgForever = SKAction.repeatActionForever(SKAction.sequence([movebg,movebgReplace]))
        
        for var index:CGFloat = 0; index < 3; index++ {
            
        background = SKSpriteNode(texture: bgTexture)
        background.position = CGPoint(x: bgTexture.size().width * (1/2 + index), y: CGRectGetMidY(self.frame))
        background.size.height = self.frame.height
        background.runAction(movebgForever)
            
            self.addChild(background)
    
        }
        
        
// add birds
        var birdTexture = SKTexture(imageNamed: "flappy1.png")
        var birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        var animation = SKAction.animateWithTextures([birdTexture,birdTexture2], timePerFrame: 0.1)
        var makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture2)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        self.addChild(bird)
        
        

        
        
        
        
           }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
           }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
