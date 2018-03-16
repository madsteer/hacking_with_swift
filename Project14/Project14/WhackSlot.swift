//
//  WhackSlot.swift
//  Project14
//
//  Created by Cory Steers on 3/15/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import SpriteKit

class WhackSlot: SKNode {

    var charNode: SKSpriteNode!

    func configure(at position: CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)

        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = nil
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        addChild(cropNode)
    }
}
