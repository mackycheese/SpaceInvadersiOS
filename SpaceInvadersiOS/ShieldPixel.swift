//
//  ShieldPixel.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/6/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class ShieldPixel {
    
    var node: SKShapeNode!
    var tileX: Int
    var tileY: Int
    
    init(posX: Float, posY: Float, tileX: Int, tileY: Int, addTo parent: SKNode) {
        node = SKShapeNode(rectOf: CGSize(width: CGFloat(shieldPixelSize), height: CGFloat(shieldPixelSize)))
        node.position = CGPoint(x: CGFloat(posX), y: CGFloat(posY))
        node.fillColor = SKColor.green
        node.strokeColor = SKColor.green
        
        node.physicsBody = SKPhysicsBody(rectangleOf: node.calculateAccumulatedFrame().size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = categoryShield
        node.physicsBody?.contactTestBitMask = contactShield
        node.physicsBody?.collisionBitMask = collisionShield
        
        self.tileX = tileX
        self.tileY = tileY
        
        parent.addChild(node)
    }
    
}
