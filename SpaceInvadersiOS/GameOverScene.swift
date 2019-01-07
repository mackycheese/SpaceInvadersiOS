//
//  GameOverScene.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/5/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameOverScene: SKScene {
    
    var hapticHeavy: UIImpactFeedbackGenerator!
    var tap2play: SKLabelNode!
    
    override func sceneDidLoad() {
        hapticHeavy = UIImpactFeedbackGenerator(style: .heavy)
        
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height
        
        let gameOverTxt: SKLabelNode = SKLabelNode(text: "You lost!")
        gameOverTxt.horizontalAlignmentMode = .center
        gameOverTxt.verticalAlignmentMode = .center
        gameOverTxt.fontSize = 60
        gameOverTxt.position = CGPoint(x: width/2, y: height/2)
        
        let boooTxt: SKLabelNode = SKLabelNode(text: "BOOOO HOOOO")
        boooTxt.color=UIColor(red: 0.3, green: 0.2, blue: 0.2, alpha: 1)
        boooTxt.fontSize=10
        boooTxt.horizontalAlignmentMode = .center
        boooTxt.verticalAlignmentMode = .center
        boooTxt.position = CGPoint(x: width/2, y: height/2+40)
        
        tap2play = SKLabelNode(text: "Tap to play again!")
        tap2play.color=UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        tap2play.fontSize=40
        tap2play.horizontalAlignmentMode = .center
        tap2play.verticalAlignmentMode = .center
        tap2play.position=CGPoint(x:width/2,y:height/2-50)
        
        addChild(gameOverTxt)
        addChild(boooTxt)
        addChild(tap2play)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 1)
        let nextScene = GameScene(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene, transition: transition)
        hapticHeavy.impactOccurred()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        tap2play.setScale(1+0.05*cos(CGFloat(5*currentTime)))
    }
    
    
}
