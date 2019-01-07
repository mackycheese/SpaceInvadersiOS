//
//  InvaderFormation.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/5/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class InvaderFormation {
    var invaders: [[Invader]]
    
    var speed: Float = 0.3
    var moveDir: Int = 1
    
    init(addTo parent: SKNode){
        invaders = Array(repeating: [], count: gridW)
        
        for x in 0..<gridW {
            invaders[x].append(Invader(type: .A, gridX: x, gridY: 0, addTo: parent))
            invaders[x].append(Invader(type: .A, gridX: x, gridY: 1, addTo: parent))
            invaders[x].append(Invader(type: .B, gridX: x, gridY: 2, addTo: parent))
            invaders[x].append(Invader(type: .B, gridX: x, gridY: 3, addTo: parent))
            invaders[x].append(Invader(type: .C, gridX: x, gridY: 4, addTo: parent))
        }
        
    }
    
    func increaseY() {
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    invaders[x][y].node.position.y-=CGFloat(cellSize)
                }
            }
        }
    }
    
    func getMinY()->Float {
        var ymin:Float=10000
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    ymin=min(ymin,Float(invaders[x][y].node.position.y))
                }
            }
        }
        return ymin
    }
    
    func getMinX()->Float{
        var xmin:Float=10000
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    xmin = min(xmin, Float(invaders[x][y].node.position.x))
                }
            }
        }
        return xmin
    }
    func getMaxX()->Float{
        var xmax:Float = -10000
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    xmax = max(xmax, Float(invaders[x][y].node.position.x))
                }
            }
        }
        return xmax
    }
    
    func findInvader(withBody body: SKPhysicsBody) -> Invader! {
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    if invaders[x][y].node.physicsBody == body {
                        return invaders[x][y]
                    }
                }
            }
        }
        return nil
    }
    
    func killInvader(withBody body: SKPhysicsBody) {
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    if invaders[x][y].node.physicsBody == body {
                        invaders[x][y].kill()
                    }
                }
            }
        }
    }
    
    func allDead() -> Bool {
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    return false
                }
            }
        }
        return true
    }
    
    var updateX: Int = 0
    var updateY: Int = 0
    
    func update(parent: SKNode, playerX: Float) -> [Bullet] {
        var bullets: [Bullet] = []
        speed+=0.0005
        for x in 0..<gridW {
            for y in 0..<gridH {
                if !invaders[x][y].dead {
                    invaders[x][y].update()
                    invaders[x][y].node.position.x+=CGFloat(speed*Float(moveDir))
                    if Float.random(in: 0...1000) < 2*speed/0.3
//                        && abs(Float(invaders[x][y].node.position.x)-playerX)<30
                    {
                        bullets.append(invaders[x][y].fire(addTo: parent))
                    }
                }
            }
        }
        if getMinX() < 0 {
            moveDir = 1
            increaseY()
        }
        if CGFloat(getMaxX()) > UIScreen.main.bounds.width {
            moveDir = -1
            increaseY()
        }
        return bullets
    }
    
}
