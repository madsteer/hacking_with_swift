//
//  GameScene.swift
//  Project20
//
//  Created by Cory Steers on 4/10/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import SpriteKit
import GameplayKit
import SpriteKit

class GameScene: SKScene {

    var scoreLabel: SKLabelNode!

    var gameTimer: Timer!
    var fireworks = [SKNode]()
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)

        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self,
                                         selector: #selector(launchFireworks),
                                         userInfo: nil, repeats: true)
    }

    @objc private func launchFireworks() {
        let movementAmount: CGFloat = 1800
        let straightUp = 0
        let fanOut = 1
        let leftToRight = 2
        let rightToLeft = 3

        switch GKRandomSource.sharedRandom().nextInt(upperBound: 4) {
        case straightUp:
            // fire five, straight up
            [512, 312, 412, 612, 712].forEach { createFirework(xMovement: 0, x: $0, y: bottomEdge) }
        case fanOut:
            // fire five, in a fan
            [(0, 512), (-200, 312), (-100, 412), (100, 612), (200, 712)].forEach {
                let m = $0
                let x = $1
                createFirework(xMovement: CGFloat(m), x: x, y: bottomEdge)
            }
        case leftToRight:
            // fire five, from the left to the right
            [400, 300, 200, 100, 0].forEach {
                createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + $0)
            }
        case rightToLeft:
            // fire five, from the right to the left
            [400, 300, 200, 100, 0].forEach {
                createFirework(xMovement: -movementAmount, x: leftEdge, y: bottomEdge + $0)
            }
        default:
            break
        }
    }

    private func createFirework(xMovement: CGFloat, x: Int, y: Int) {
        // 1
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        // 2
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        // 3
        switch GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        {
        case 0:
            firework.color = .cyan
        case 1:
            firework.color = .green
        case 2:
            firework.color = .red
        default:
            break
        }
        // 4
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: xMovement, y: 1000))
        // 5
        let move = SKAction.follow(path.cgPath, asOffset: true,
                                   orientToPath: true, speed: 50)
        node.run(move)
        // 6
        let emitter = SKEmitterNode(fileNamed: "fuse")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        // 7
        fireworks.append(node)
        addChild(node)
    }

    func explodeFireworks() {
        var numExploded = 0

//        fireworks.forEach {
//            if $0.name == "selected" {
//                explode(firework: $0)
//                numExploded += 1
//            }
//        }
//        fireworks = fireworks.filter { $0.name != "selected" }

        for (index, fireworkContainer) in
            fireworks.enumerated().reversed() {
                let firework = fireworkContainer.children[0] as!
                SKSpriteNode
                if firework.name == "selected" {
                    // destroy this firework!
                    explode(firework: fireworkContainer)
                    fireworks.remove(at: index)
                    numExploded += 1
                }
        }

//        score += exponent(numExploded) * 100
        switch numExploded {
        case 0:
            // nothing – rubbish!
            break
        case 1:
            score += 200
        case 2:
            score += 500
        case 3:
            score += 1500
        case 4:
            score += 2500
        default:
            score += 4000
        }
    }

    private func exponent(_ num: Int) -> Int {
        switch num {
        case 0:
            return 0
        case 1:
            return 1
        default:
            return num + (num - 1)
        }
    }

    private func explode(firework: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "explode")!
        emitter.position = firework.position
        addChild(emitter)
        firework.removeFromParent()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    private func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        for node in nodesAtPoint {
            if node is SKSpriteNode {
                let sprite = node as! SKSpriteNode
                if sprite.name == "firework" {
//                    let selectedFireworks = fireworks.filter { $0.name == "selected" }
//                    selectedFireworks.forEach {
//                        let fw = $0 as! SKSpriteNode
//                        if fw.name == "selected" && fw.color != sprite.color {
//                            fw.name = "firework"
//                            fw.colorBlendFactor = 1
//                        }
//                    }

                    for parent in fireworks {
                        let firework = parent.children[0] as! SKSpriteNode
                        if firework.name == "selected" && firework.color !=
                            sprite.color {
                            firework.name = "firework"
                            firework.colorBlendFactor = 1
                        }
                    }

                    sprite.name = "selected"
                    sprite.colorBlendFactor = 0
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
//        fireworks.forEach { if $0.position.y > 900 { $0.removeFromParent() } }
//        fireworks = fireworks.filter { $0.position.y <= 900 }

        for (index, firework) in fireworks.enumerated().reversed() {
            if firework.position.y > 900 {
                // this uses a position high above so that rockets can explode off screen
                fireworks.remove(at: index)
                firework.removeFromParent()
            }
        }
    }
}
