//
//  GameScene.swift
//  PlinkADink
//
//  Created by Demian Turner on 20/01/2016.
//  Copyright (c) 2016 Seagull Systems. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var discs = [SKSpriteNode]()
    var remainingLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    let numberOfDiscs = 15
    let postWidth = CGFloat(10)
    
    let discCategory : UInt32 = 1 << 0
    let pegCategory : UInt32 = 1 << 1
    let postCategory : UInt32 = 1 << 2
    let bigGoalCategory : UInt32 = 1 << 3
    let mediumGoalCategory : UInt32 = 1 << 4
    let smallGoalCategory : UInt32 = 1 << 5
    let borderCategory : UInt32 = 1 << 6
    
    var score = 0
    
    override func didMove(to view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
//        view.showsPhysics = true
        
        self.makeTopLabels()
        self.makeWallsAndGround()
        self.makePosts()
        self.makeGoals()
        self.makeGoalScoreLabels()
        self.makePegs(10, numbersOfRows: 10, pegRadius: 4, rowSpacing: 40, yStart: 120)
    }
    
    func makeTopLabels() {
        self.remainingLabel = SKLabelNode(text: "Remaining: \(self.numberOfDiscs)")
        self.remainingLabel.fontColor = UIColor.black
        self.remainingLabel.fontSize = 20
        self.remainingLabel.position = CGPoint(x: self.frame.size.width * 0.25, y: self.frame.size.height - 20.0)
        self.addChild(self.remainingLabel)
        
        self.scoreLabel = SKLabelNode(text: "Score: 0")
        self.scoreLabel.fontColor = UIColor.black
        self.scoreLabel.fontSize = 20
        self.scoreLabel.position = CGPoint(x: self.frame.size.width * 0.75, y: self.frame.size.height - 20.0)
        self.addChild(self.scoreLabel)
    }
    
    func updateLabels() {
        self.remainingLabel.text = "Remaining \(self.numberOfDiscs - self.discs.count)"
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    
    func makeWallsAndGround() {
        let ground = SKSpriteNode(color: UIColor.red, size: CGSize(width: self.frame.size.width, height: 20))
        ground.position = CGPoint(x: self.frame.size.width/2, y: -10)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 20))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = self.borderCategory
        self.addChild(ground)
        
        let leftWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: self.frame.size.height))
        leftWall.position = CGPoint(x: -10, y: self.frame.size.height/2)
        leftWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: self.frame.size.height))
        leftWall.physicsBody?.isDynamic = false
        leftWall.physicsBody?.categoryBitMask = self.borderCategory
        self.addChild(leftWall)
        
        let rightWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 20, height: self.frame.size.height))
        rightWall.position = CGPoint(x: self.frame.size.width + 10, y: self.frame.size.height/2)
        rightWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: self.frame.size.height))
        rightWall.physicsBody?.isDynamic = false
        rightWall.physicsBody?.categoryBitMask = self.borderCategory
        self.addChild(rightWall)
    }
    
    func makePegs(_ numberOfPegsInRow : Int, numbersOfRows : Int, pegRadius : CGFloat, rowSpacing : CGFloat, yStart : CGFloat) {
        
        for rowNumber in 0...(numberOfPegsInRow - 1) {

            let pegSpacing = (self.frame.size.width - (CGFloat(numberOfPegsInRow) * pegRadius * 2)) /  CGFloat(numberOfPegsInRow + 1)
            
            var extraSpacing = CGFloat(0)
            if rowNumber % 2 == 1 {
                extraSpacing = pegSpacing / 2
            }
            
            for pegNumber in 0...(numberOfPegsInRow - 1) {
                
                let peg = SKSpriteNode(imageNamed: "ball0")
//                let peg = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: pegRadius * 2, height: pegRadius * 2))
                let sub1 = extraSpacing + (pegSpacing * 0.75) + pegRadius
                let sub2 = pegRadius * 2 * CGFloat(pegNumber)
                let sub3 = pegSpacing * CGFloat(pegNumber)
                peg.position = CGPoint(x: sub1 + sub2 + sub3, y: yStart + CGFloat(rowNumber) * rowSpacing)
                peg.physicsBody = SKPhysicsBody(circleOfRadius: pegRadius)
                peg.physicsBody?.isDynamic = false
                peg.physicsBody?.categoryBitMask = self.pegCategory
                self.addChild(peg)
            }
        }
    }
    
    func makePosts() {
        
        let postHeight = CGFloat(80)
        
        let post1 = SKSpriteNode(color: UIColor.red, size: CGSize(width: self.postWidth, height: postHeight))
        post1.position = CGPoint(x: self.frame.size.width  * 0.25, y: postHeight/2)
        post1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.postWidth, height: postHeight))
        post1.physicsBody?.isDynamic = false
        post1.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post1)
        
        let post2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: self.postWidth, height: postHeight))
        post2.position = CGPoint(x: self.frame.size.width * 0.45, y: postHeight/2)
        post2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.postWidth, height: postHeight))
        post2.physicsBody?.isDynamic = false
        post2.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post2)
        
        let post3 = SKSpriteNode(color: UIColor.red, size: CGSize(width: self.postWidth, height: postHeight))
        post3.position = CGPoint(x: self.frame.size.width  * 0.55, y: postHeight/2)
        post3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.postWidth, height: postHeight))
        post3.physicsBody?.isDynamic = false
        post3.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post3)
        
        let post4 = SKSpriteNode(color: UIColor.red, size: CGSize(width: self.postWidth, height: postHeight))
        post4.position = CGPoint(x: self.frame.size.width  * 0.75, y: postHeight/2)
        post4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.postWidth, height: postHeight))
        post4.physicsBody?.isDynamic = false
        post4.physicsBody?.categoryBitMask = self.postCategory
        self.addChild(post4)
    }
    
    func makeGoals() {
        let goalHeight = CGFloat(70)
        let bigGoalWidth = (self.frame.size.width * 0.25) - (self.postWidth / 2)
        let mediumGoalLength = (self.frame.size.width * 0.2) - self.postWidth
        let smallGoalLength = (self.frame.size.width * 0.1) - self.postWidth
        let yPosition = goalHeight/2
        
        let goal1 = SKNode()
        goal1.position = CGPoint(x: bigGoalWidth / 2, y: yPosition)
        goal1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bigGoalWidth, height: goalHeight))
        goal1.physicsBody?.isDynamic = false
        goal1.physicsBody?.categoryBitMask = self.bigGoalCategory
        self.addChild(goal1)
        
        let xPosition2 = bigGoalWidth + self.postWidth + (mediumGoalLength / 2)
        let goal2 = SKNode()
        goal2.position = CGPoint(x: xPosition2, y: yPosition)
        goal2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mediumGoalLength, height: goalHeight))
        goal2.physicsBody?.isDynamic = false
        goal2.physicsBody?.categoryBitMask = self.mediumGoalCategory
        self.addChild(goal2)
        
        let xPosition3 = bigGoalWidth + self.postWidth + mediumGoalLength + self.postWidth + (smallGoalLength / 2)
        let goal3 = SKNode()
        goal3.position = CGPoint(x: xPosition3, y: yPosition)
        goal3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mediumGoalLength, height: goalHeight))
        goal3.physicsBody?.isDynamic = false
        goal3.physicsBody?.categoryBitMask = self.smallGoalCategory
        self.addChild(goal3)
        
        let xPosition4 = bigGoalWidth + self.postWidth * 3 + mediumGoalLength + smallGoalLength + mediumGoalLength / 2
        let goal4 = SKNode()
        goal4.position = CGPoint(x: xPosition4, y: yPosition)
        goal4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mediumGoalLength, height: goalHeight))
        goal4.physicsBody?.isDynamic = false
        goal4.physicsBody?.categoryBitMask = self.mediumGoalCategory
        self.addChild(goal4)
        
        let xPosition5 = bigGoalWidth + self.postWidth * 4 + mediumGoalLength + smallGoalLength + mediumGoalLength + bigGoalWidth / 2
        let goal5 = SKNode()
        goal5.position = CGPoint(x: xPosition5, y: yPosition)
        goal5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bigGoalWidth, height: goalHeight))
        goal5.physicsBody?.isDynamic = false
        goal5.physicsBody?.categoryBitMask = self.bigGoalCategory
        self.addChild(goal5)
        
    }
    
    func makeGoalScoreLabels() {
        let goalHeight = CGFloat(70)
        let bigGoalWidth = (self.frame.size.width * 0.25) - (self.postWidth / 2)
        let mediumGoalLength = (self.frame.size.width * 0.2) - self.postWidth
        let smallGoalLength = (self.frame.size.width * 0.1) - self.postWidth
        let yPosition = goalHeight/2
        
        
        let left100 = SKLabelNode(text: "100")
        left100.fontColor = UIColor.black
        left100.fontSize = 20
        let XPosition = bigGoalWidth / 2
        left100.position = CGPoint(x: XPosition, y: yPosition)
        self.addChild(left100)
        
        let left200 = SKLabelNode(text: "200")
        left200.fontColor = UIColor.black
        left200.fontSize = 20
        let xPosition2 = bigGoalWidth + self.postWidth + (mediumGoalLength / 2)
        left200.position = CGPoint(x: xPosition2, y: yPosition)
        self.addChild(left200)
        
        let centre = SKLabelNode(text: "💰")
        centre.fontColor = UIColor.black
        centre.fontSize = 20
        let xPosition3 = bigGoalWidth + self.postWidth + mediumGoalLength + self.postWidth + (smallGoalLength / 2)
        centre.position = CGPoint(x: xPosition3, y: yPosition)
        self.addChild(centre)
        
        let right200 = SKLabelNode(text: "200")
        right200.fontColor = UIColor.black
        right200.fontSize = 20
        let xPosition4 = bigGoalWidth + self.postWidth * 3 + mediumGoalLength + smallGoalLength + mediumGoalLength / 2
        right200.position = CGPoint(x: xPosition4, y: yPosition)
        self.addChild(right200)
        
        let right100 = SKLabelNode(text: "100")
        right100.fontColor = UIColor.black
        right100.fontSize = 20
        let xPosition5 = bigGoalWidth + self.postWidth * 4 + mediumGoalLength + smallGoalLength + mediumGoalLength + bigGoalWidth / 2
        right100.position = CGPoint(x: xPosition5, y: yPosition)
        self.addChild(right100)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            
            if self.discs.count >= self.numberOfDiscs {
                self.removeChildren(in: self.discs)
                self.discs = []
                self.updateLabels()
                self.score = 0
                
            } else {
                let disc = SKSpriteNode(imageNamed:"ball\(self.discs.count + 1)")
                
                disc.xScale = 0.05
                disc.yScale = 0.05
                disc.position = touch.location(in: self)
                
                disc.physicsBody = SKPhysicsBody(circleOfRadius: disc.size.height/4)
                disc.physicsBody?.categoryBitMask = self.discCategory
                disc.physicsBody?.collisionBitMask = self.pegCategory | self.postCategory | self.borderCategory | self.discCategory
                disc.physicsBody?.contactTestBitMask = self.smallGoalCategory | self.mediumGoalCategory | self.bigGoalCategory
                
                self.addChild(disc)
                
                self.discs.append(disc)
                self.updateLabels()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == self.bigGoalCategory || contact.bodyB.categoryBitMask == self.bigGoalCategory {
            print("big")
            self.score += 100
        }
        if contact.bodyA.categoryBitMask == self.mediumGoalCategory || contact.bodyB.categoryBitMask == self.mediumGoalCategory {
            print("medium")
            self.score += 200
        }
        if contact.bodyA.categoryBitMask == self.smallGoalCategory || contact.bodyB.categoryBitMask == self.smallGoalCategory {
            print("small")
            self.score += 500
        }
        updateLabels()
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
}
