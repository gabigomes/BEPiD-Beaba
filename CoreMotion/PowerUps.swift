//
//  PowerUps.swift
//  CoreMotion
//
//  Created by Pedro Lopes on 8/7/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import Foundation

import SpriteKit


class PowerUps: SKSpriteNode {
    
    var actionMoverPowerUp : SKAction!
    var actionDeletarPowerUp = SKAction.removeFromParent()
    
    let CollisionJogador     : UInt32 = 0x1 << 1
    let CollisionPowerUp : UInt32 = 0x1 << 2
    
    init(size : CGSize, Power: String)
    {
        super.init(texture: SKTexture(imageNamed: Power), color: UIColor.clearColor(), size: size)
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(60))
        self.physicsBody?.dynamic = false
        self.physicsBody!.categoryBitMask = CollisionPowerUp
        self.physicsBody!.contactTestBitMask = CollisionJogador
        self.name = Power
    }
    
    func runPowerUpAction(sizeY : CGFloat) {
        
        actionMoverPowerUp = SKAction.moveByX(0, y: -850, duration: 6.0)
        
        let randomY = Int(arc4random_uniform(874)) + 50
        
        self.position = CGPoint(x: CGFloat(randomY), y: 775)
        
        self.runAction(SKAction.sequence([actionMoverPowerUp, actionDeletarPowerUp]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}