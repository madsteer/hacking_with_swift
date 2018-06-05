//
//  GameScene.swift
//  Project26
//
//  Created by Cory Steers on 5/18/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import SpriteKit
import GameplayKit

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
}

enum NodeType: Character {
    case wall = "x"
    case vortex = "v"
    case star = "s"
    case finish = "f"
}

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        loadLevel()
        createPlayer()
    }

    private func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue |
            CollisionTypes.vortex.rawValue |
            CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    private func loadLevel() {
        if let levelPath = Bundle.main.path(forResource: "level1", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath) {
                let lines = levelString.components(separatedBy: "\n")
                for (row, line) in lines.reversed().enumerated() {
                    for (column, letter) in line.enumerated() {
                        let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                        switch letter {
                        case NodeType.wall.rawValue:
                            loadWall(at: position)
                        case NodeType.vortex.rawValue:
                            loadVortex(at: position)
                        case NodeType.star.rawValue:
                           loadStar(at: position)
                        case NodeType.finish.rawValue:
                            loadFinish(at: position)
                        default:
                            continue
                        }
                    }
                }
            }
        }
    }

    private func loadFinish(at position: CGPoint) {
        let node = loadNodeWithCirclePhysicsBody(at: position, of: CollisionTypes.star.rawValue,
                                                 named: "finish")
        addChild(node)    }

    private func loadStar(at position: CGPoint) {
        let node = loadNodeWithCirclePhysicsBody(at: position, of: CollisionTypes.star.rawValue,
                                                 named: "star")
        addChild(node)
    }

    private func loadVortex(at position: CGPoint) {
        let node = loadNodeWithCirclePhysicsBody(at: position, of: CollisionTypes.vortex.rawValue,
                                                 named: "vortex")

//        let node = SKSpriteNode(imageNamed: "vortex")
//        node.name = "vortex"
//        node.position = position
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi, duration: 1)))
//        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
//        node.physicsBody?.isDynamic = false
//        node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
//        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
//        node.physicsBody?.collisionBitMask = 0
        addChild(node)
    }

    private func loadWall(at position: CGPoint) {
        let node = loadBasicNode(at: position, of: CollisionTypes.wall.rawValue, named: "block")
        addChild(node)
    }

    private func loadNodeWithCirclePhysicsBody(at position: CGPoint, of category: UInt32, named name: String)
        -> SKSpriteNode {

        let node = SKSpriteNode(imageNamed: name)
        node.name = name
        node.position = position
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = category
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0

        return node
    }

    private func loadBasicNode(at position: CGPoint, of type: UInt32, named name: String) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: name)
        node.position = position
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = type
        node.physicsBody?.isDynamic = false

        return node
    }
}
