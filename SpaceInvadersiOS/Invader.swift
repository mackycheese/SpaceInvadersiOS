//
//  Invader.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/4/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

enum InvaderType: String {
    case A = "A"
    case B = "B"
    case C = "C"
}

class Invader {
    
    var node: SKSpriteNode!
    var type: InvaderType!
    var tex1: SKTexture!
    var tex2: SKTexture!
    var dead: Bool = false

    init(type: InvaderType, gridX gx: Int, gridY gy: Int, addTo parent: SKNode) {
        self.type = type
        
        tex1 = SKTexture(imageNamed: "Invader"+type.rawValue+"_00")
        tex2 = SKTexture(imageNamed: "Invader"+type.rawValue+"_01")
        node = SKSpriteNode(texture: tex1)
        node.setScale(CGFloat(invaderScale))
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        node.position = CGPoint(x: CGFloat(Float(gx)*cellSize+formationX), y: (CGFloat(Float(gy)*cellSize+formationY)))
        
        node.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Invader"+type.rawValue+"_00"), size: node.calculateAccumulatedFrame().size)
        node.physicsBody?.affectedByGravity=false
        node.physicsBody?.allowsRotation=false
        node.physicsBody?.isDynamic=false
        
        node.physicsBody?.categoryBitMask = categoryInvader
        node.physicsBody?.contactTestBitMask = contactInvader
        node.physicsBody?.collisionBitMask = collisionInvader
        
        node.physicsBody?.angularDamping = 0
        node.physicsBody?.linearDamping = 0

        parent.addChild(node)
    }
    
    func fire(addTo parent: SKNode) -> Bullet {
        return Bullet(posX: Float(node.position.x), posY: Float(node.position.y), speed: -bulletSpeed, fromPlayer: false, addTo: parent)
    }
    
    func kill(){
        node.removeFromParent()
        dead=true
    }
    
    var frames: Int = 0
    let framesPerUpdate: Int = 30
    
    func update() {
        frames += 1
        let frame = (frames/framesPerUpdate)%2
        if frame == 0 {
            node.texture = tex1
        } else {
            node.texture = tex2
        }
    }
    
}
