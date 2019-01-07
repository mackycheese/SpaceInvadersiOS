//
//  Bullet.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/5/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet {
    var node: SKShapeNode!

    init(posX: Float, posY: Float, speed: Float, fromPlayer: Bool, addTo: SKNode) {
        node = SKShapeNode(rectOf: CGSize(width: 0, height: 6))
        node.fillColor = UIColor.white
        node.position = CGPoint(x: CGFloat(posX), y: CGFloat(posY))
        node.physicsBody = SKPhysicsBody(rectangleOf: node.calculateAccumulatedFrame().size)
        node.physicsBody?.affectedByGravity=false
        node.physicsBody?.allowsRotation=false
        node.physicsBody?.isDynamic=true
        node.physicsBody?.angularDamping = 0
        node.physicsBody?.linearDamping = 0
        
        if fromPlayer {
            node.physicsBody?.categoryBitMask = categoryPlayerBullet
            node.physicsBody?.contactTestBitMask = contactPlayerBullet
            node.physicsBody?.collisionBitMask = collisionPlayerBullet
        } else {
            node.physicsBody?.categoryBitMask = categoryInvaderBullet
            node.physicsBody?.contactTestBitMask = contactInvaderBullet
            node.physicsBody?.collisionBitMask = collisionInvaderBullet
        }
        
        node.physicsBody?.velocity=CGVector(dx: 0, dy: CGFloat(speed))
        
        addTo.addChild(node)
    }
}
