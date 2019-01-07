//
//  GameViewController.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/4/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as? SKView
        
        let scene: SKScene = GameStartScene(size: skView!.bounds.size)
//        skView!.showsFPS=true
//        skView!.showsNodeCount=true
//        skView!.showsDrawCount=true
//        skView!.showsQuadCount=true
//        skView!.showsPhysics=true
        try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try! AVAudioSession.sharedInstance().setActive(true)
        
        skView!.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
