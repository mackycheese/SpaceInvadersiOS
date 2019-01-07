//
//  GameScene.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/4/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    //TODO: App icon, polish the game, "shields"
    var formation: InvaderFormation!
    var player: Spaceship!
    
    var hapticHeavy: UIImpactFeedbackGenerator!
    
    var motionManager: CMMotionManager!
    
    var bullets: [Bullet] = []
    var shields: [ShieldPixel] = []
    
    override func sceneDidLoad() {
        hapticHeavy = UIImpactFeedbackGenerator(style: .heavy)
        player = Spaceship(addTo: self)
        formation = InvaderFormation(addTo: self)
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        
        let numBunkers: Float = 3
        let screenW: Float = Float(UIScreen.main.bounds.width)
        for i in 0..<Int(numBunkers) {
            addBunker(posX: screenW*(0.5+Float(i))/numBunkers)
        }
    }
    
    func addBunker(posX: Float) {
        for x in -3...3 {
            for y in 0...3 {
                shields.append(ShieldPixel(posX: posX+Float(x)*shieldPixelSize, posY: 50+Float(y)*shieldPixelSize, tileX: x, tileY: y, addTo: self))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA: SKPhysicsBody = contact.bodyA
        let bodyB: SKPhysicsBody = contact.bodyB
        
        let hitInvader: Bool = (bodyA.categoryBitMask == categoryInvader || bodyB.categoryBitMask == categoryInvader)
        let hitInvaderBullet: Bool = (bodyA.categoryBitMask == categoryInvaderBullet || bodyB.categoryBitMask == categoryInvaderBullet)
        let hitPlayer: Bool = (bodyA.categoryBitMask == categoryPlayer || bodyB.categoryBitMask == categoryPlayer)
        let hitPlayerBullet: Bool = (bodyA.categoryBitMask == categoryPlayerBullet || bodyB.categoryBitMask == categoryPlayerBullet)
        let hitShield: Bool = (bodyA.categoryBitMask == categoryShield || bodyB.categoryBitMask == categoryShield)
        
        if hitShield {
            killShield(withBody: bodyA)
            killShield(withBody: bodyB)
            killBullet(withBody: bodyA)
            killBullet(withBody: bodyB)
        }
        
        if hitInvader && hitPlayerBullet {
            formation.killInvader(withBody: bodyA)
            formation.killInvader(withBody: bodyB)
            killBullet(withBody: bodyA)
            killBullet(withBody: bodyB)
            hapticHeavy.impactOccurred()
        }
        
        if hitPlayerBullet && hitInvaderBullet {
            killBullet(withBody: bodyA)
            killBullet(withBody: bodyB)
            hapticHeavy.impactOccurred()
        }
        
        if (hitPlayer && hitInvaderBullet) || (hitPlayer && hitInvader) {
            hapticHeavy.impactOccurred()
            let transition: SKTransition = SKTransition.fade(withDuration: 1.0)
            let newScene: SKScene = GameOverScene(size: scene!.size)
            view?.presentScene(newScene, transition: transition)
        }

    }
    
    func killBullet(withBody body: SKPhysicsBody) {
        for i in 0..<bullets.count {
            if bullets[i].node.physicsBody == body {
                bullets[i].node.removeFromParent()
                bullets.remove(at: i)
                return
            }
        }
    }
    
    func killShield(withBody body: SKPhysicsBody) {
        
//        var shield: ShieldPixel! = nil
        for i in 0..<shields.count {
            if shields[i].node.physicsBody == body {
//                shield = shields[i]
                shields[i].node.removeFromParent()
                shields = shields.filter { $0 !== shields[i] }
                return
            }
        }
        
//        if shield != nil {
//            var toRem: [ShieldPixel]=[]
//            for i in 0..<shields.count {
//                let x0: Float = Float(shield.tileX)
//                let y0: Float = Float(shield.tileY)
//                let x1: Float = Float(shields[i].tileX)
//                let y1: Float = Float(shields[i].tileY)
//                let dist: Float = sqrt( (x0-x1)*(x0-x1) + (y0-y1)*(y0-y1)  )
//                if dist<4 {
//                    toRem.append(shields[i])
//                }
//            }
//            for i in 0..<toRem.count {
//                toRem[i].node.removeFromParent()
//                shields = shields.filter { $0 !== toRem[i] }
//            }
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bullets.append(player.fire(addTo: self))
        hapticHeavy.impactOccurred()
    }
    
    override func update(_ currentTime: TimeInterval) {
        bullets.append(contentsOf: formation.update(parent: self, playerX: Float(player.node.position.x)))
        if motionManager.accelerometerData != nil {
            player.moveX = 9*Float((motionManager.accelerometerData?.acceleration.x)!)
        }
        player.update()
        
        if formation.getMinY() < Float(player.node.position.y) {
            hapticHeavy.impactOccurred()
            let transition: SKTransition = SKTransition.fade(withDuration: 1.0)
            let newScene: SKScene = GameOverScene(size: scene!.size)
            view?.presentScene(newScene, transition: transition)
        }
        
        if formation.allDead() {
            let transition: SKTransition = SKTransition.fade(withDuration: 1.0)
            let newScene: SKScene = LevelOverScene(size: scene!.size)
            view?.presentScene(newScene, transition: transition)
            hapticHeavy.impactOccurred()
        }
        
    }
}
