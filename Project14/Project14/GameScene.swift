//
//  GameScene.swift
//  Project14
//
//  Created by Cory Steers on 3/15/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }

    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var slots = [WhackSlot]()
    private var slotLocations = [
        SlotLocation(x: 100, y: 410),
        SlotLocation(x: 180, y: 320),
        SlotLocation(x: 100, y: 230),
        SlotLocation(x: 180, y: 140)
    ]
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        createSlots()
    }

    private func createSlots() {
        for (index, location) in slotLocations.enumerated() {
            let max = index % 2 == 0 ? 5 : 4
            for i in 0 ..< max {
                createSlot(at: CGPoint(x: location.x + (i * SlotLocation.modifier), y: location.y))
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    private func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
}
