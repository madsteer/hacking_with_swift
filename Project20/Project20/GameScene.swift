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
    
    var gameTimer: Timer!
    var fireworks = [SKNode]()
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    var score = 0 {
        didSet {
            // your code here
        }
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

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
                                   orientToPath: true, speed: 200)
        node.run(move)
        // 6
        let emitter = SKEmitterNode(fileNamed: "fuse")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        // 7
        fireworks.append(node)
        addChild(node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
