//
//  Spaceship.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/5/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class Spaceship {
    var node: SKSpriteNode!
    var moveX: Float = 0
    
    init(addTo parent: SKNode) {
        node = SKSpriteNode(imageNamed: "Ship")
        
        node.position = CGPoint(x: UIScreen.main.bounds.width/2, y: 20)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        node.physicsBody = SKPhysicsBody(rectangleOf: node.calculateAccumulatedFrame().size)
        node.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Ship"), size: node.calculateAccumulatedFrame().size)
        node.physicsBody?.affectedByGravity=false
        node.physicsBody?.allowsRotation=false
        node.physicsBody?.isDynamic=false
        node.physicsBody?.categoryBitMask = categoryPlayer
        node.physicsBody?.contactTestBitMask = contactPlayer
        node.physicsBody?.collisionBitMask = collisionPlayer
        node.physicsBody?.angularDamping = 0
        node.physicsBody?.linearDamping = 0

        parent.addChild(node)
    }
    
    func update() {
        node.position.x += CGFloat(moveX)
        if node.position.x<0{
            node.position.x=0
        }
        if node.position.x>UIScreen.main.bounds.width{
            node.position.x=UIScreen.main.bounds.width
        }
    }
    
    func fire(addTo parent: SKNode) -> Bullet {
        return Bullet(posX: Float(node.position.x), posY: Float(node.position.y), speed: bulletSpeed, fromPlayer: true, addTo: parent)
    }
    
}
