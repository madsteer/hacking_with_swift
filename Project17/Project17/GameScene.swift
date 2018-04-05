//
//  GameScene.swift
//  Project17
//
//  Created by Cory Steers on 3/29/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    var livesImages = [SKSpriteNode]()
    var lives = 3
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    var activeSlicePoints = [CGPoint]()
    var activeEnemies = [SKSpriteNode]()

    var isSwooshSoundActive = false
    var bombSoundEffect: AVAudioPlayer!

    var popupTime = 0.9
    var sequence: [SequenceType]!
    var sequencePosition = 0
    var chainDelay = 3.0
    var nextSequenceQueued = true

    var gameEnded = false

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85

        createScore()
        createLives()
        createSlices()

        sequence = [.oneNoBomb, .oneNoBomb, .twoWithOneBomb, .twoWithOneBomb, .three, .one, .chain]
        for _ in 0 ... 1000 {
            let nextSequence = SequenceType(rawValue: RandomInt(min: 2, max: 7))!
            sequence.append(nextSequence)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.tossEnemies()
        }
    }

    private func tossEnemies() {
        guard gameEnded == false else { return }

        popupTime *= 0.991
        chainDelay *= 0.99
        physicsWorld.speed *= 1.02
        let sequenceType = sequence[sequencePosition]

        switch sequenceType {
        case .oneNoBomb:
            createEnemy(forceBomb: .never)
        case .one:
            createEnemy()
        case .twoWithOneBomb:
            createEnemy(forceBomb: .never)
            createEnemy(forceBomb: .always)
        case .two:
            createEnemy()
            createEnemy()
        case .three:
            for _ in 0 ..< 3 {
                createEnemy()
            }
        case .four:
            for _ in 0 ..< 4 {
                createEnemy()
            }
        case .chain:
            createEnemy()
            for cnt in 1 ... 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 5.0 * Double(cnt)))
                { [unowned self] in self.createEnemy() }
            }
        case .fastChain:
            createEnemy()
            for cnt in 1 ... 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + (chainDelay / 10.0 * Double(cnt)))
                    { [unowned self] in self.createEnemy() }
            }
        }
        sequencePosition += 1
        nextSequenceQueued = false
    }

    private func createEnemy(forceBomb: ForceBomb = .random) {
        var enemy: SKSpriteNode

        let localForceBomb = (forceBomb == .random) ? ForceBomb.randomize() : forceBomb

        if localForceBomb == .always {
            enemy = makeBomb()
        } else {
            enemy = SKSpriteNode(imageNamed: "penguin")
            run(SKAction.playSoundFileNamed("launch.caf",
                                            waitForCompletion: false))
            enemy.name = "enemy"
        }

        enemy = position(enemy: enemy)

        addChild(enemy)
        activeEnemies.append(enemy)
    }

    private func position(enemy: SKSpriteNode) -> SKSpriteNode {
        // 1
        let randomPosition = CGPoint(x: RandomInt(min: 64, max: 960),
                                     y: -128)
        enemy.position = randomPosition
        // 2
        let randomAngularVelocity = CGFloat(RandomInt(min: -6, max: 6)) / 2.0
        var randomXVelocity = 0
        // 3
        switch randomPosition.x {
        case 0 ..< 256:
            randomXVelocity = RandomInt(min: 8, max: 15)
        case 256 ..< 512:
            randomXVelocity = RandomInt(min: 3, max: 5)
        case 512 ..< 768:
            randomXVelocity = -RandomInt(min: 3, max: 5)
        default:
            randomXVelocity = -RandomInt(min: 8, max: 15)
        }
        // 4
        let randomYVelocity = RandomInt(min: 24, max: 32)
        // 5
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40,
                                               dy: randomYVelocity * 40)
        enemy.physicsBody?.angularVelocity = randomAngularVelocity
        enemy.physicsBody?.collisionBitMask = 0

        return enemy
    }

    private func makeBomb() -> SKSpriteNode {
        // 1
        let enemy = SKSpriteNode()
        enemy.zPosition = 1
        enemy.name = "bombContainer"
        // 2
        let bombImage = SKSpriteNode(imageNamed: "sliceBomb")
        bombImage.name = "bomb"
        enemy.addChild(bombImage)
        // 3
        if bombSoundEffect != nil {
            bombSoundEffect.stop()
            bombSoundEffect = nil
        }
        // 4
        let path = Bundle.main.path(forResource: "sliceBombFuse.caf",
                                    ofType:nil)!
        let url = URL(fileURLWithPath: path)
        let sound = try! AVAudioPlayer(contentsOf: url)
        bombSoundEffect = sound
        sound.play()
        // 5
        let emitter = SKEmitterNode(fileNamed: "sliceFuse")!
        emitter.position = CGPoint(x: 76, y: 64)
        enemy.addChild(emitter)
        return enemy
    }

    private func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        gameScore.position = CGPoint(x: 8, y: 8)
    }

    private func createLives() {
        for i in 0 ..< 3 {
            let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
            spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)),
                                          y: 720)
            addChild(spriteNode)
            livesImages.append(spriteNode)
        }
    }

    private func createSlices() {
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2

        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 2

        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9,
                                            blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9

        activeSliceFG.strokeColor = UIColor.white
        activeSliceFG.lineWidth = 5

        addChild(activeSliceBG)
        addChild(activeSliceFG)
    }

    private func redrawActiveSlice() {
        if activeSlicePoints.count < 2 {
            activeSliceBG.path = nil
            activeSliceFG.path = nil
            return
        }

        activeSlicePoints = Array(activeSlicePoints.suffix(12))

        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])

        for i in 1 ..< activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }

        activeSliceBG.path = path.cgPath
        activeSliceFG.path = path.cgPath
    }

    override func update(_ currentTime: TimeInterval) {
        if activeEnemies.count > 0 {
            for node in activeEnemies {
                if node.position.y < -140 {
                    node.removeFromParent()

                    if node.name == "enemy" {
                        node.name = ""
                        subtractLife()
                        node.removeFromParent()
                        if let index = activeEnemies.index(of: node) {
                            activeEnemies.remove(at: index)
                        }
                    } else if node.name == "bombContainer" {
                        node.name = ""
                        node.removeFromParent()
                        if let index = activeEnemies.index(of: node) {
                            activeEnemies.remove(at: index)
                        }
                    }
                }
            }
        } else {
            if !nextSequenceQueued {
                DispatchQueue.main.asyncAfter(deadline: .now() + popupTime) {
                    [unowned self] in
                    self.tossEnemies()
                }
                nextSequenceQueued = true
            }
        }

        var bombCount = 0

        for node in activeEnemies {
            if node.name == "bombContainer" {
                bombCount += 1
                break
            }
        }
        
        if bombCount == 0 {
            // no bombs – stop the fuse sound!
            if bombSoundEffect != nil {
                bombSoundEffect.stop()
                bombSoundEffect = nil
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        activeSlicePoints.removeAll(keepingCapacity: true)

        if let touch = touches.first {
            let location = touch.location(in: self)
            activeSlicePoints.append(location)
            redrawActiveSlice()
            activeSliceBG.removeAllActions()
            activeSliceFG.removeAllActions()
            activeSliceBG.alpha = 1
            activeSliceFG.alpha = 1
        }
    }

    private func sliceEnemy(_ node: SKNode) {
        // 1
        let emitter = SKEmitterNode(fileNamed: "sliceHitEnemy")!
        emitter.position = node.position
        addChild(emitter)
        // 2
        node.name = ""
        // 3
        node.physicsBody?.isDynamic = false
        // 4
        let scaleOut = SKAction.scale(to: 0.001, duration:0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let group = SKAction.group([scaleOut, fadeOut])
        // 5
        let seq = SKAction.sequence([group, SKAction.removeFromParent()])
        node.run(seq)
        // 6
        score += 1
        // 7
        let index = activeEnemies.index(of: node as! SKSpriteNode)!
        activeEnemies.remove(at: index)
        // 8
        run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
    }

    private func sliceBomb(_ node: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "sliceHitBomb")!
        emitter.position = node.parent!.position
        addChild(emitter)
        node.name = ""
        node.parent?.physicsBody?.isDynamic = false
        let scaleOut = SKAction.scale(to: 0.001, duration:0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        let group = SKAction.group([scaleOut, fadeOut])
        let seq = SKAction.sequence([group, SKAction.removeFromParent()])
        node.parent?.run(seq)
        let index = activeEnemies.index(of: node.parent as! SKSpriteNode)!
        activeEnemies.remove(at: index)
        run(SKAction.playSoundFileNamed("explosion.caf", waitForCompletion: false))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard gameEnded == false else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        redrawActiveSlice()

        if !isSwooshSoundActive {
            playSwooshSound()
        }

        let nodesAtPoint = nodes(at: location)
        for node in nodesAtPoint {
            if node.name == "enemy" {
                sliceEnemy(node)
            } else if node.name == "bomb" {
                sliceBomb(node)
                endGame(triggeredByBomb: true)
            }
        }
    }

    private func playSwooshSound() {
        isSwooshSoundActive = true
        let randomNumber = RandomInt(min: 1, max: 3)
        let soundName = "swoosh\(randomNumber).caf"
        let swooshSound = SKAction.playSoundFileNamed(soundName,
                                                      waitForCompletion: true)
        run(swooshSound) { [unowned self] in
            self.isSwooshSoundActive = false
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

    private func subtractLife() {
        lives -= 1
        run(SKAction.playSoundFileNamed("wrong.caf", waitForCompletion: false))
        var life: SKSpriteNode

        switch lives {
        case 1:
            life = livesImages[1]
        case 2:
            life = livesImages[0]
        default:
            life = livesImages[2]
            endGame(triggeredByBomb: false)
        }


        life.texture = SKTexture(imageNamed: "sliceLifeGone")
        life.xScale = 1.3
        life.yScale = 1.3
        life.run(SKAction.scale(to: 1, duration:0.1))
    }

    private func endGame(triggeredByBomb: Bool) {
        if gameEnded {
            return
        }
        gameEnded = true
        physicsWorld.speed = 0
        isUserInteractionEnabled = false
        if bombSoundEffect != nil {
            bombSoundEffect.stop()
            bombSoundEffect = nil
        }
        if triggeredByBomb {
            livesImages.forEach { $0.texture = SKTexture(imageNamed: "sliceLifeGone") }
        }
    }
}
