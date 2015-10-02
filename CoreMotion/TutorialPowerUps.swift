//
//  TutorialPowerUps.swift
//  CoreMotion
//
//  Created by Gabriela  Gomes Pires on 10/08/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import SpriteKit
import AVFoundation

class TutorialPowerUps : SKScene {
    
    var audioPlay = AVAudioPlayer()
    var pres = NSURL()
    let fundo = SKSpriteNode(imageNamed: "Fundo-.png")
    let botaoPowerUp1 = SKSpriteNode(imageNamed: "Desacelerar5segundos")
    let botaoPowerUp2 = SKSpriteNode(imageNamed: "PreencheUmaLetra")
    let botaoPowerUp3 = SKSpriteNode(imageNamed: "Ganha5pontos")
    let botaoPowerUp4 = SKSpriteNode(imageNamed: "MoveMaisRapido5segundos")
    let botaoPowerUp5 = SKSpriteNode(imageNamed: "ImuneAsLetrasErradasPor10Segundos")
    let botaoPowerUp6 = SKSpriteNode(imageNamed: "GanhaUmaVida")
    let botaoPowerUp7 = SKSpriteNode(imageNamed: "DestacaLetrasCertas")
    let botaoPowerUp8 = SKSpriteNode(imageNamed: "MultiplicadorDePontos")
    let botaoPowerUp9 = SKSpriteNode(imageNamed: "CompletarApalavra")
    let botaoPowerUp10 = SKSpriteNode(imageNamed: "Acelerar5segundos")
    let botaoPowerUp11 = SKSpriteNode(imageNamed: "InverterComandos")
    let botaoPowerUp12 = SKSpriteNode(imageNamed: "ApagaUmaLetra")
    let botaoPowerUp13 = SKSpriteNode(imageNamed: "Perde5pontos")
    let botaoPowerUp14 = SKSpriteNode(imageNamed: "MoveMaisDevagar5segundos")
    let botaoVoltar = SKSpriteNode(imageNamed: "BtnVolta")
//    let som: Sons = Sons()

    
    override func didMoveToView(view: SKView) {
        
        criaTela()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let touch = touches.first as UITouch?
        let touchLocation = touch!.locationInNode(self)
        chamaAudioPowerUp(touchLocation)
    }
    
    func criaTela(){
        fundo.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundo.setScale(0.5)
        
        botaoPowerUp1.position = CGPointMake(CGRectGetMidX(self.frame)-375,CGRectGetMidY(self.frame)+255)
        botaoPowerUp1.setScale(0.3)
        
        botaoPowerUp2.position = CGPointMake(CGRectGetMidX(self.frame)-223,CGRectGetMidY(self.frame)+255)
        botaoPowerUp2.setScale(0.3)
        
        botaoPowerUp3.position = CGPointMake(CGRectGetMidX(self.frame)-71,CGRectGetMidY(self.frame)+255)
        botaoPowerUp3.setScale(0.3)
        
        botaoPowerUp4.position = CGPointMake(CGRectGetMidX(self.frame)+81,CGRectGetMidY(self.frame)+255)
        botaoPowerUp4.setScale(0.3)
        
        botaoPowerUp5.position = CGPointMake(CGRectGetMidX(self.frame)+233,CGRectGetMidY(self.frame)+255)
        botaoPowerUp5.setScale(0.3)
        
        botaoPowerUp6.position = CGPointMake(CGRectGetMidX(self.frame)+385,CGRectGetMidY(self.frame)+255)
        botaoPowerUp6.setScale(0.3)
        
        botaoPowerUp7.position = CGPointMake(CGRectGetMidX(self.frame)-375,CGRectGetMidY(self.frame)+40)
        botaoPowerUp7.setScale(0.3)
        
        botaoPowerUp8.position = CGPointMake(CGRectGetMidX(self.frame)-223,CGRectGetMidY(self.frame)+40)
        botaoPowerUp8.setScale(0.3)
        
        botaoPowerUp9.position = CGPointMake(CGRectGetMidX(self.frame)-71,CGRectGetMidY(self.frame)+40)
        botaoPowerUp9.setScale(0.3)
        
        botaoPowerUp10.position = CGPointMake(CGRectGetMidX(self.frame)-375,CGRectGetMidY(self.frame)-160)
        botaoPowerUp10.setScale(0.3)
        
        botaoPowerUp11.position = CGPointMake(CGRectGetMidX(self.frame)-223,CGRectGetMidY(self.frame)-160)
        botaoPowerUp11.setScale(0.3)
        
        botaoPowerUp12.position = CGPointMake(CGRectGetMidX(self.frame)-71,CGRectGetMidY(self.frame)-160)
        botaoPowerUp12.setScale(0.3)
        
        botaoPowerUp13.position = CGPointMake(CGRectGetMidX(self.frame)+81,CGRectGetMidY(self.frame)-160)
        botaoPowerUp13.setScale(0.3)
        
        botaoPowerUp14.position = CGPointMake(CGRectGetMidX(self.frame)+233,CGRectGetMidY(self.frame)-160)
        botaoPowerUp14.setScale(0.3)
        
        botaoVoltar.position = CGPointMake(CGRectGetMidX(self.frame)-465, CGRectGetMidY(self.frame)+330)
        botaoVoltar.setScale(0.5)
        
        self.addChild(fundo)
        self.addChild(botaoPowerUp1)
        self.addChild(botaoPowerUp2)
        self.addChild(botaoPowerUp3)
        self.addChild(botaoPowerUp4)
        self.addChild(botaoPowerUp5)
        self.addChild(botaoPowerUp6)
        self.addChild(botaoPowerUp7)
        self.addChild(botaoPowerUp8)
        self.addChild(botaoPowerUp9)
        self.addChild(botaoPowerUp10)
        self.addChild(botaoPowerUp11)
        self.addChild(botaoPowerUp12)
        self.addChild(botaoPowerUp13)
        self.addChild(botaoPowerUp14)
        self.addChild(botaoVoltar)
    }
    
    func chamaAudioPowerUp(touchLocation : CGPoint){
        if(botaoPowerUp1.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("DesaceleraAvelocidadeQueAsLetrasCaem", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp1.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp2.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PreencheUmaLetra", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp2.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp3.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("GanhaMaisCincoPontos", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp3.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp4.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("OpersonagemSeMoveMaisRapido", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp4.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp5.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("FicaImuneAsLetrasErradas", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp5.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp6.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("GanhaUmaVida", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp6.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp7.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("DestacaAletraCerta", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp7.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp8.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("MultiplicaOsPontosGanho", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp8.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp9.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CompletaApalavra", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp9.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp10.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("AsLetrasCaemMaisDepressa", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp10.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp11.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("InverteOsComandos", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp11.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp12.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ApagaUmaLetra", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp12.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp13.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PerdeCincoPontos", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp13.runAction(action)
            tocaAudio()
        }
        else if(botaoPowerUp14.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("OpersonagemFicaMaisLento", ofType: "mp3")!)
            let action = SKAction.sequence([SKAction.scaleTo(0.3, duration: 0.15), SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.3, duration: 0.15)])
            botaoPowerUp14.runAction(action)
            tocaAudio()
        }
        else if(botaoVoltar.containsPoint(touchLocation)){
            self.pres = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("(Botão CC)164703__mishicu__sfx-21-mo", ofType: "wav")!)
            tocaAudio()
            
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.5, duration: 0.15)])
            botaoVoltar.runAction(action)
            
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("volta"), userInfo: nil, repeats: false)
        }
    }
    
    func volta(){
        let transition = SKTransition()
        let cenarioMenu = Menu(size: self.size)
        cenarioMenu.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioMenu, transition: transition)
    }
    
    func tocaAudio(){
        do{
            try audioPlay = AVAudioPlayer(contentsOfURL: pres)
            audioPlay.volume = 2.0
            audioPlay.play()
        }
        catch{
            error
        }
    }
    
}
