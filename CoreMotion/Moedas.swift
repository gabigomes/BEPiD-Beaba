//
//  Moedas.swift
//  CoreMotion
//
//  Created by Gabriela  Gomes Pires on 10/08/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import Foundation

import SpriteKit


class Moedas: SKSpriteNode {
    
    var actionMoverMoedas : SKAction!
    var actionDeletarMoedas = SKAction.removeFromParent()
    
    let CollisionJogador     : UInt32 = 0x1 << 1
    let CollisionMoedas : UInt32 = 0x1 << 2
    
    init(size : CGSize, Moeda: String)
    {
        super.init(texture: SKTexture(imageNamed: Moeda), color: UIColor.clearColor(), size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 40, height: 40))
        self.physicsBody?.dynamic = false
        self.physicsBody!.categoryBitMask = CollisionMoedas
        self.physicsBody!.contactTestBitMask = CollisionJogador
        self.name = Moeda
    }
    
    func runMoedaAction(sizeY : CGFloat) {
        
        actionMoverMoedas = SKAction.moveByX(0, y: -850, duration: 6.0)
        
        let randomY = Int(arc4random_uniform(874)) + 50
        
        self.position = CGPoint(x: CGFloat(randomY), y: 775)
        
        self.runAction(SKAction.sequence([actionMoverMoedas, actionDeletarMoedas]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}