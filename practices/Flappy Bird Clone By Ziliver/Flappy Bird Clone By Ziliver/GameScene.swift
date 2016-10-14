//
//  GameScene.swift
//  (135)adding and animating sprite
//
//  Created by yuanzichao on 1/6/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import SpriteKit

class GameScene: SKScene , SKPhysicsContactDelegate {
    
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    var gameOver = 0
    var gameOverLabel = SKLabelNode()
    
    var bird = SKSpriteNode()
    var background = SKSpriteNode()
    
    var labelHoder = SKSpriteNode()
    
    let birdGroup: UInt32 = 1
    let objectGroup: UInt32 = 2
    let gapGroup: UInt32 = 0 << 3 //read more info about it
    
    var movingObjects = SKNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVectorMake(0, -10)
        
        self.addChild(movingObjects)
        self.addChild(labelHoder)
        // add backgrounds
        
        
        CreateBackGround()
        
        // score label
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 70
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.height - 70)
        scoreLabel.zPosition = 20
        self.addChild(scoreLabel)
        
        
        // add birds
        var birdTexture = SKTexture(imageNamed: "flappy1.png")
        var birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        var animation = SKAction.animateWithTextures([birdTexture,birdTexture2], timePerFrame: 0.1)
        var makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture2)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        
        // put in the front of the screen
        bird.zPosition = 10
        
        //control the bird
        
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: self.bird.size.height/2)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = true
        bird.physicsBody?.categoryBitMask = birdGroup
        bird.physicsBody?.collisionBitMask = gapGroup
        bird.physicsBody?.contactTestBitMask = objectGroup
        
        self.addChild(bird)
        
        //add a ground
        
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize:  CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = objectGroup
        
        self.addChild(ground)
        
        // add a pipe constantly
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(2.1, target: self, selector: ("makePipes"), userInfo: nil, repeats: true)
        
        
        
    }
    
    func makePipes(){
        
        if gameOver == 0 {
            
            var pipeMovement = SKAction.moveByX( -self.frame.size.width * 2, y: 0, duration: NSTimeInterval( self.frame.size.width / 100))
            
            var removePipes = SKAction.removeFromParent()
            
            var addAndRemovePipes = SKAction.sequence([pipeMovement,removePipes])
            
            var gapHeight = self.bird.size.height * 4
            
            var randomNum = arc4random() % UInt32(self.frame.size.height / 2)
            
            var pipeOffSet = CGFloat(randomNum) - self.frame.size.height/4
            
            var pipe1Texture = SKTexture(imageNamed: "pipe1.png")
            var pipe1 = SKSpriteNode(texture: pipe1Texture)
            pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipe1.size.height/2 + gapHeight/2 + pipeOffSet)
            pipe1.runAction(addAndRemovePipes)
            
            pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
            pipe1.physicsBody?.dynamic = false
            pipe1.physicsBody?.categoryBitMask = objectGroup
            
            movingObjects.addChild(pipe1)
            
            
            var pipe2Texture = SKTexture(imageNamed: "pipe2.png")
            var pipe2 = SKSpriteNode(texture: pipe2Texture)
            pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipe2.size.height/2 - gapHeight/2 + pipeOffSet)
            pipe2.runAction(addAndRemovePipes)
            
            pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
            pipe2.physicsBody?.dynamic = false
            pipe2.physicsBody?.categoryBitMask = objectGroup
            
            
            movingObjects.addChild(pipe2)
            
            
            var gap = SKNode()
            gap.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeOffSet)
            gap.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipe2.size.width, gapHeight))
            gap.runAction(addAndRemovePipes)
            gap.physicsBody?.dynamic = false
            gap.physicsBody?.collisionBitMask = gapGroup
            gap.physicsBody?.contactTestBitMask = birdGroup
            gap.physicsBody?.categoryBitMask = gapGroup
            movingObjects.addChild(gap)
            
            
        }
    }
    func CreateBackGround(){
        var bgTexture = SKTexture(imageNamed: "bg.png")
        
        var movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var movebgReplace = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var movebgForever = SKAction.repeatActionForever(SKAction.sequence([movebg,movebgReplace]))
        
        for var index:CGFloat = 0; index < 3; index++ {
            
            background = SKSpriteNode(texture: bgTexture)
            background.position = CGPoint(x: bgTexture.size().width * (1/2 + index), y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.height
            background.runAction(movebgForever)
            
            movingObjects.addChild(background)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup{
            print("gap contact")
            score++
            scoreLabel.text = "\(score)"
            
            
        }
        else{
            if gameOver == 0 {
                
                print("You lost!")
                gameOver = 1
                movingObjects.speed = 0
                gameOverLabel.fontName = "Helvetica"
                gameOverLabel.fontSize = 30
                gameOverLabel.text = "Game Over, tap to restart"
                gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                gameOverLabel.zPosition = 20
                labelHoder.addChild(gameOverLabel)
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if gameOver == 0 {
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        }else{
            scoreLabel.text = "0"
            score = 0
            movingObjects.removeAllChildren()
            CreateBackGround()
            bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            
            labelHoder.removeAllChildren()
            gameOver = 0
            
            movingObjects.speed = 1
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
