//
//  GameScene.swift
//  Project23
//
//  Created by Cory Steers on 5/1/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer!
    var isGameOver = false

    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        starfield = SKEmitterNode(fileNamed: "Starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        starfield.zPosition = -1
        starfield.name = "Starfield"
        addChild(starfield)

        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!,
                                           size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)

        score = 0
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self

        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy),
                                         userInfo: nil, repeats: true)
    }

    @objc private func createEnemy() {
        possibleEnemies = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleEnemies) as! [String]
        let randomDistribution = GKRandomDistribution(lowestValue: 50, highestValue: 736)
        let sprite = SKSpriteNode(imageNamed: possibleEnemies[0])
        sprite.position = CGPoint(x: 1200, y: randomDistribution.nextInt())
        addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0

        // they're just too darn big to avoid
        sprite.setScale(0.5)
    }

    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
                if !isGameOver {
                    score += 1
                }
            }
        }

//        if !isGameOver {
//            score += 1
//        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        player.position = location
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        player.removeFromParent()
        isGameOver = true

        gameTimer.invalidate()
//        sleep(3)
//        if let node = childNode(withName: "Starfield") {
//            node.removeFromParent()
//        }

//        sleep(1)
//        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in self.scene?.view?.isPaused = true} )
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(restartGame), userInfo: nil, repeats: false)
//        self.scene?.view?.isPaused = true
    }

    @objc private func restartGame() {
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.position = CGPoint(x: 400, y: 384)
//        gameOverLabel.position = CGPoint(x: 25, y: 25)
        gameOverLabel.horizontalAlignmentMode = .left
        gameOverLabel.text = "Play again?"
        addChild(gameOverLabel)

        if let node = childNode(withName: "Starfield") {
            node.removeFromParent()
        }
//        scene?.view?.isPaused = true
    }
}
