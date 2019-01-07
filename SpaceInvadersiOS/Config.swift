//
//  Config.swift
//  SpaceInvadersiOS
//
//  Created by Jack Armstrong on 1/5/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation

let gridW: Int = 11
let gridH: Int = 5
let cellSize: Float = 25
let formationX: Float = 30
let formationY: Float = 200
let invaderScale: Float = 0.7
let bulletSpeed: Float = 150
let shieldPixelSize: Float = 8

let categoryPlayer        : UInt32 = UInt32("00001", radix: 2)!
let categoryPlayerBullet  : UInt32 = UInt32("00010", radix: 2)!
let categoryInvader       : UInt32 = UInt32("00100", radix: 2)!
let categoryInvaderBullet : UInt32 = UInt32("01000", radix: 2)!
let categoryShield        : UInt32 = UInt32("10000", radix: 2)!

let contactPlayer         : UInt32 = UInt32("01111", radix: 2)!
let contactPlayerBullet   : UInt32 = UInt32("11111", radix: 2)!
let contactInvader        : UInt32 = UInt32("01111", radix: 2)!
let contactInvaderBullet  : UInt32 = UInt32("11111", radix: 2)!
let contactShield         : UInt32 = UInt32("01010", radix: 2)!

let collisionPlayer       : UInt32 = UInt32("01100", radix: 2)!
let collisionPlayerBullet : UInt32 = UInt32("11100", radix: 2)!
let collisionInvader      : UInt32 = UInt32("00011", radix: 2)!
let collisionInvaderBullet: UInt32 = UInt32("10011", radix: 2)!
let collisionShield       : UInt32 = UInt32("01010", radix: 2)!
