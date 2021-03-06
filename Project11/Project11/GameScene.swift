//
//  GameScene.swift
//  Project11
//
//  Created by Cory Steers on 3/9/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var editLabel: SKLabelNode!

    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }


    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self

        for x in [0, 256, 512, 768, 1024] {
            makeBouncer(at: CGPoint(x: x, y: 0))
        }

        for (index, x) in [128, 384, 640, 896].enumerated() {
            makeSlot(at: CGPoint(x: x, y:0), isGood: index % 2 == 0)
        }

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)

        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
    }

    private func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

    private func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        switch isGood {
        case true:
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        case false:
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }

        slotBase.position = position
        slotGlow.position = position

        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false

        addChild(slotBase)
        addChild(slotGlow)

        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }

    private func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }

        ball.removeFromParent()
    }

    private func collisionBetween(ball: SKNode, object: SKNode) {
        if let name = object.name {
            switch name {
            case "good":
                destroy(ball: ball)
                score += 1
            case "bad":
                destroy(ball: ball)
                score -= 1
            default: return
            }
        }
    }

    internal func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "ball" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    fileprivate func placeNewBall(_ location: CGPoint) {
        let balls = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.balls()) as! [String]
        let ball = SKSpriteNode(imageNamed: balls[0])
        ball.name = "ball"

        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.physicsBody?.restitution = 0.4

        ball.position = CGPoint(x: location.x, y: super.size.height)

        addChild(ball)
    }

    fileprivate func placeNewObsticle(_ location: CGPoint) {
        let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue: 128).nextInt(),
                          height: 16)
        let box = SKSpriteNode(color: RandomColor(), size: size)
        box.name = "obsticle"
        box.zRotation = RandomCGFloat(min: 0, max: 3)
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        addChild(box)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)

            let objects = nodes(at: location)
            let obsticles = objects.filter { $0.name == "obsticle" }

            if objects.contains(editLabel) {
                editingMode = !editingMode
            } else if !obsticles.isEmpty {
                obsticles[0].removeFromParent()
            }else {
                if editingMode {
                    placeNewObsticle(location)
                } else {
                    placeNewBall(location)
                }
            }
        }
    }

    private func balls() -> [String] {
        var balls = [String]()
        balls.append("ballBlue")
        balls.append("ballCyan")
        balls.append("ballGreen")
        balls.append("ballGrey")
        balls.append("ballPurple")
        balls.append("ballRed")
        balls.append("ballYello")
        
        return balls
    }
}
