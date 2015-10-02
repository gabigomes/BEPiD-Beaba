//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


class Letras: SKSpriteNode {
    
    var actionMoverInimigo : SKAction!
    var actionDeletarInimigo = SKAction.removeFromParent()
    
    let CollisionJogador     : UInt32 = 0x1 << 1
    let CollisionInimigo : UInt32 = 0x1 << 2
    
    var duracao: NSTimeInterval = 10.0
    
    init(size : CGSize, Letra: String)
    {
        super.init(texture: SKTexture(imageNamed: Letra), color: UIColor.clearColor(), size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 40, height: 70))
        self.physicsBody?.dynamic = false
        self.physicsBody!.categoryBitMask = CollisionInimigo
        self.physicsBody!.contactTestBitMask = CollisionJogador
        self.name = Letra
    }

    
    var velocidade = 0
    
    
    func checaVelocidade(velocidade: Int){
        
        if velocidade == -1 {
            duracao = 15.0
        }
        
        else if velocidade == 0 {
            duracao = 10.0
        }
        
        else if velocidade == 1 {
            duracao = 5.0
        }
        
        
        runLetraAction(size.height, duracao: self.duracao)
    }
    
    func runLetraAction(sizeY : CGFloat, duracao : NSTimeInterval) {
        
        actionMoverInimigo = SKAction.moveByX(0, y: -850, duration: self.duracao)
        
        let randomY = Int(arc4random_uniform(874)) + 50
        
        self.position = CGPoint(x: CGFloat(randomY), y: 775)
        
        self.runAction(SKAction.sequence([actionMoverInimigo, actionDeletarInimigo]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}