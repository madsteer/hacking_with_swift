//
//  GameScene.swift
//  Project14
//
//  Created by Cory Steers on 3/15/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import SpriteKit
import GameplayKit

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
    private var popupTime = 0.85
    var numRounds = 0
    let startAndFinishLocation = CGPoint(x: 512, y: 384)
    
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

        resetGame()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
//            self.createEnemy()
//        }
    }

    private func createSlots() {
        for (index, location) in slotLocations.enumerated() {
            let max = index % 2 == 0 ? 5 : 4
            for i in 0 ..< max {
                createSlot(at: CGPoint(x: location.x + (i * SlotLocation.modifier), y: location.y))
            }
        }
    }

    private func createEnemy() {
        numRounds += 1
        if numRounds > 29 {
            endGame()
            return
        }
        
        popupTime *= 0.991
        slots = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: slots) as! [WhackSlot]
        slots[0].show(hideTime: popupTime)
        if RandomInt(min: 0, max: 12) > 4 { slots[1].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 8 {  slots[2].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 10 { slots[3].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 11 { slots[4].show(hideTime: popupTime)  }
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = RandomDouble(min: minDelay, max: maxDelay)

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            self.createEnemy()
        }
    }

    private func endGame() {
        for slot in slots {
            slot.hide()
        }

        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.name = "gameOver"
        gameOver.position = startAndFinishLocation
        gameOver.zPosition = 1
        addChild(gameOver)
    }

    private func resetGame() {
        numRounds = 0
        score = 0
        popupTime = 0.85
        let startGame = SKSpriteNode(imageNamed: "startGame")
        startGame.name = "startGame"
        startGame.position = startAndFinishLocation
        startGame.zPosition = 1
        addChild(startGame)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)

//            let gameOverNode = SKSpriteNode(imageNamed: "gameOver")
//            if tappedNodes.contains(gameOverNode) {
//                removeChildren(in: [gameOverNode])
//                resetGame()
//                return
//            }
//
//            let startGameNode = SKSpriteNode(imageNamed: "startGame")
//            if tappedNodes.contains(startGameNode) {
//                removeChildren(in: [startGameNode])
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
//                    self.createEnemy()
//                }
//                return
//            }

            for node in tappedNodes {
                if let penguin = node.parent,
                    let whackSlot = penguin.parent as? WhackSlot {

                    if node.name == "charFriend" {
                        if !whackSlot.isVisible { continue }
                        if whackSlot.isHit { continue }
                        whackSlot.hit()
                        score -= 5

                        run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
                    } else if node.name == "charEnemy" {
                        if !whackSlot.isVisible { continue }
                        if whackSlot.isHit { continue }
                        whackSlot.charNode.xScale = 0.85
                        whackSlot.charNode.yScale = 0.85
                        whackSlot.hit()
                        score += 1
                        run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
                    }
                }

                if node.name == "gameOver" {
                    removeChildren(in: [node])
                    resetGame()
                    return
                }

                if node.name == "startGame" {
                    removeChildren(in: [node])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                        self.createEnemy()
                    }
                    return
                }
            }
        }
    }

    private func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
}
