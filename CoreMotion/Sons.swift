//
//  Sons.swift
//  CoreMotion
//
//  Created by Gabriela  Gomes Pires on 31/07/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import Foundation
import AVFoundation

class Sons{
    
    var audioPlay = AVAudioPlayer()
    var audioDaLetra = AVAudioPlayer()
    var audioPlayFundo = AVAudioPlayer()
    var powerUp = AVAudioPlayer()
    let a = "(BotãoInicio CC)317789__jalastram__sfx-powerup-21"
    
    
    var botaoGeral = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("(Botão CC)164703__mishicu__sfx-21-mo", ofType: "wav")!)
    var musicaFundo = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("492666_Up-Up-and-Away", ofType: "mp3")!)
    var letraCerta =  NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("(LetraCerta CC)242501__gabrielaraujo__powerup-success", ofType: "wav")!)
    
    var tocaPowerUp = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("(powerup CC)198808__jobro__magical-thing", ofType: "wav")!)
    
    func playAudioBotaoInicio(){
        let botaoInicio = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(a, ofType: "wav")!)
        do{
           try audioPlay = AVAudioPlayer(contentsOfURL: botaoInicio)
            audioPlay.volume = 2.0
            audioPlay.play()
        }
        catch{
            error
        }
    }
    
    func playAudioBotoesGeral(){
        do{
            try audioPlay = AVAudioPlayer(contentsOfURL: botaoGeral)
            audioPlay.volume = 2.0
            audioPlay.play()
        }
        catch{
            error
        }
    }
    
    func playPowerUp(){
        do{
            try powerUp = AVAudioPlayer(contentsOfURL: tocaPowerUp)
            powerUp.volume = 0.7
            powerUp.play()
        }
        catch{
            error
        }
    }
    
    func musicaDeFundo(){
        do{
            try audioPlayFundo = AVAudioPlayer(contentsOfURL: musicaFundo)
            audioPlayFundo.volume = 0.3
            audioPlayFundo.play()
            audioPlayFundo.numberOfLoops = -1
        }
        catch{
            error
        }
    }
    
    func acertouPalavra(){
        do{
            try audioPlay = AVAudioPlayer(contentsOfURL: letraCerta)
            audioPlay.volume = 2.0
            audioPlay.play()
        }
        catch{
            error
        }
    }
    
    func tocaLetraCerta(letrinha : NSString){
        let letraDaVez = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(letrinha as String, ofType: "mp3")!)
        do{
            try audioDaLetra = AVAudioPlayer(contentsOfURL: letraDaVez)
            audioDaLetra.volume = 4.5
            audioDaLetra.play()
        }
        catch{
            error
        }
    }
}