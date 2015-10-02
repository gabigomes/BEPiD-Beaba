//
//  Menu.swift
//  CoreMotion
//
//  Created by Gabriela  Gomes Pires on 31/07/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import SpriteKit

class Menu: SKScene {
    
    //Variaveis
    let fundoInicio = SKSpriteNode(imageNamed: "FundoInicio.png")
    let botaoIniciar = SKSpriteNode (imageNamed: "BtnIniciar.png")
    let botaoPersonagem = SKSpriteNode (imageNamed: "BtnPersInicio.png")
    let botaoCompra = SKSpriteNode (imageNamed: "BtnComprar.png")
    let botaoInformacao = SKSpriteNode(imageNamed: "Btn-.png")
    var personagem = SKSpriteNode()
    var clicou = false
    var som : Sons = Sons()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Caracteristicas da imagem de fundo.
        fundoInicio.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundoInicio.xScale = 0.5
        fundoInicio.yScale = 0.5
        
        //Botao Iniciar o Jogo.
        botaoIniciar.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        botaoIniciar.xScale = 0.5
        botaoIniciar.yScale = 0.5
        
        //Botão Para escolher o personagem.
        botaoPersonagem.position = CGPointMake(CGRectGetMidX(self.frame)+360,CGRectGetMidY(self.frame)+140)
        botaoPersonagem.xScale = 0.5
        botaoPersonagem.yScale = 0.5
        
        //Botão Para compras
        botaoCompra.position = CGPointMake(CGRectGetMidX(self.frame)+420,CGRectGetMidY(self.frame)-300)
        botaoCompra.xScale = 0.5
        botaoCompra.yScale = 0.5
        
        //Botao Para Tela de explicação
        botaoInformacao.position = CGPointMake(CGRectGetMidX(self.frame)-380,CGRectGetMidY(self.frame)+20)
        botaoInformacao.setScale(0.5)
        
        //Adicionando elementos na tela.
        self.addChild(fundoInicio)
        self.addChild(botaoIniciar)
        self.addChild(botaoPersonagem)
        self.addChild(botaoCompra)
        self.addChild(personagem)
        self.addChild(botaoInformacao)
        desenhoDoBotao()
    }
    
    
    //Função reconhece e chama a cena de acordo com a localização do clique.
    func chamadaCena(touchLocation : CGPoint){
        
        if(botaoIniciar.containsPoint(touchLocation) && !self.clicou){
            clicou = true
            som.playAudioBotaoInicio()
            
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.5, duration: 0.15)])
            botaoIniciar.runAction(action)
            
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("chamaCenaJogo"), userInfo: nil, repeats: false)
        }
        else if(botaoPersonagem.containsPoint(touchLocation)){
            som.playAudioBotoesGeral()
            
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.1), SKAction.scaleTo(0.5, duration: 0.1)])
            _ = personagem.size
            let action2 = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.1), SKAction.scaleTo(0.4, duration: 0.1)])
            botaoPersonagem.runAction(action)
            personagem.runAction(action2)
            
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("chamaCenaPersonagem"), userInfo: nil, repeats: false)
        }
        else if(botaoCompra.containsPoint(touchLocation)){
            som.playAudioBotoesGeral()
            
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.1), SKAction.scaleTo(0.5, duration: 0.1)])
            botaoCompra.runAction(action)
            
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("chamaCenaLoja"), userInfo: nil, repeats: false)
        }
        else if(botaoInformacao.containsPoint(touchLocation)){
            som.playAudioBotoesGeral()
            
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.1), SKAction.scaleTo(0.5, duration: 0.1)])
            botaoInformacao.runAction(action)
            
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("chamaTutorial"), userInfo: nil, repeats: false)
        }
    }
    
    func chamaCenaJogo(){
        let transition = SKTransition()
        let cenarioJogo = GameScene(size: self.size)
        cenarioJogo.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioJogo, transition: transition)
    }
    
    func chamaCenaPersonagem(){
        let transition = SKTransition()
        let cenarioPersonagem = Personagens(size: self.size)
        cenarioPersonagem.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioPersonagem, transition: transition)
    }
    
    func chamaCenaLoja(){
        let transition = SKTransition()
        let cenarioLoja = Loja(size: self.size)
        cenarioLoja.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioLoja, transition: transition)
    }
    
    func chamaTutorial(){
        let transition = SKTransition()
        let cenarioTutorial = TutorialPowerUps(size: self.size)
        cenarioTutorial.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioTutorial, transition: transition)
    }
    
    func desenhoDoBotao (){
        let defaults = NSUserDefaults.standardUserDefaults()
        let escolha = defaults.integerForKey("personagem")
        
        if escolha == 0 {
            self.personagem = SKSpriteNode(imageNamed: "Auau.png")
            personagem.position = CGPointMake(CGRectGetMidX(self.frame)+380,CGRectGetMidY(self.frame)+140)
            personagem.setScale(0.4)
        }
        else if escolha == 1{
            self.personagem = SKSpriteNode(imageNamed: "Miau.png")
            personagem.position = CGPointMake(CGRectGetMidX(self.frame)+360,CGRectGetMidY(self.frame)+140)
            personagem.setScale(0.4)
        }
        else if escolha == 2{
            self.personagem = SKSpriteNode(imageNamed: "bolinha.png")
            personagem.position = CGPointMake(CGRectGetMidX(self.frame)+360,CGRectGetMidY(self.frame)+140)
            personagem.setScale(0.4)
        }
        else if escolha == 3{
            self.personagem = SKSpriteNode(imageNamed: "bigodinho.png")
            personagem.position = CGPointMake(CGRectGetMidX(self.frame)+365,CGRectGetMidY(self.frame)+140)
            personagem.setScale(0.4)
        }
        personagem.zPosition = 1
        self.addChild(personagem)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let touch = touches.first as UITouch?
        let touchLocation = touch!.locationInNode(self)
        chamadaCena(touchLocation)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
