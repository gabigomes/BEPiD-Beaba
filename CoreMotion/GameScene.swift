//
//  GameScene.swift
//  CodeMotionExemplo
//
//  Created by Lucca Marmion on 22/06/15.
//  Copyright (c) 2015 LuccaMarmion. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate
{
    //Fundo
    var fundo : SKSpriteNode!
    var personagem : SKSpriteNode!
    var palavra : SKSpriteNode!
    var letraAtingida: SKNode!
    var textoPontuacao = SKLabelNode()
    var textoPontos = SKLabelNode()
    var pontos = 0
    var erros = 0
    var clicouNoPause = false
    var moedinhas = 0
    var pontuacaoMaxima = 0
    var palavrasCertas = 0
    var anterior: String!
    var moedas = NSUserDefaults.standardUserDefaults()
    var highScore = NSUserDefaults.standardUserDefaults()
    var contMoedas = 0
    var gameAtivo = false
    var velocidadeLetras = 0
    var ativo : Bool = false
    var ativoAcelerometro : Bool = false
    var ativoImune : Bool = false
    var ativoDestaca : Bool = false
    var clicou = false
    var velocidade : CGFloat = 700.0
    let coreMotionManager = CMMotionManager()
    var yAxisAcceleration : CGFloat = 0.0
    let botaoPause = SKSpriteNode(imageNamed: "BtnPausar.png")
    let botaoContinuar = SKSpriteNode(imageNamed: "BtnContinuar.png")
    let botaoSair = SKSpriteNode(imageNamed: "BtnSair.png")
    let fundoEscurecido = SKSpriteNode(imageNamed: "FundoPausar.png")
    let fundoPause = SKSpriteNode(imageNamed: "BtnFundo.png")
    let fundoGameOver = SKSpriteNode(imageNamed: "FundoGameOver")
    let botaoJogar = SKSpriteNode(imageNamed: "BtnJogar")
    let botaoMenu = SKSpriteNode(imageNamed: "BtnMenu")
    var pausado = false
    var som : Sons = Sons ()
    var range = 0
    var a = 1
    var flag = 0
    var nomePowerUp = SKSpriteNode()
    var count: CGFloat = 0
    var vida1 = SKSpriteNode(imageNamed: "vida")
    var vida2 = SKSpriteNode(imageNamed: "vida")
    var vida3 = SKSpriteNode(imageNamed: "vida")
    var vida4 = SKSpriteNode(imageNamed: "vida")
    var vida5 = SKSpriteNode(imageNamed: "vida")
    var actionVidas = SKAction.sequence([SKAction.scaleTo(0.5, duration: 0.5), SKAction.scaleTo(0.0, duration: 0.5)])
    var actionVidas2 = SKAction.sequence([SKAction.scaleTo(0.0, duration: 0.5), SKAction.scaleTo(0.3, duration: 0.5)])
    var power: String!
    var contato = 1
    var palavraArray: NSMutableArray!
    var sorteada: String = ""
    var array = [""]
    let arrayVida = ["vida","vida","vida","vida","vida"]
    
    
    let arrayPowerUps = ["Acelerar5segundos", "ApagaUmaLetra", "GanhaUmaVida", "CompletarApalavra", "Desacelerar5segundos", "DestacaLetrasCertas", "Ganha5pontos", "ImuneAsLetrasErradasPor10Segundos", "InverterComandos", "MoveMaisDevagar5segundos", "MoveMaisRapido5segundos", "MultiplicadorDePontos", "Perde5pontos", "PreencheUmaLetra"]
    

    let nivel1 = ["amor", "bala", "bela", "bico", "bobo", "boca", "bode", "boi", "bola", "bolo", "bota", "bule", "caco", "caju", "cama", "cana", "capa", "cela", "coco", "cola", "copa", "copo", "dado", "dama", "dedo", "doce", "faca", "fada", "figo", "fila", "fita", "flor", "foca", "fogo", "fome", "galo", "gato", "gola", "goma", "gota", "hora", "jaca", "jogo", "lado", "laje", "lama", "lata", "ler", "lima", "lixo", "lona", "lote", "lua", "luta", "luva", "luxo", "luz", "mala", "mato", "meia", "mico", "mola", "muda", "mula", "nato", "nave", "neva", "neve", "nota", "nove", "novo", "ovo", "pano", "pata", "pato", "pelo", "pia", "pipa", "pote", "pulo", "rato", "rede", "rei", "rio", "rodo", "roxo", "rua", "saco", "sapo", "sara", "sete", "sono", "sopa", "soro", "taco", "tatu", "tela", "tia", "time", "toca", "tubo", "uva", "vaca", "vaso", "veia", "vela", "vida", "viga", "viva", "vivo"]
    
    let nivel2 = ["abacate", "abacaxi", "ardente", "baleia", "banana", "barata", "batata", "bateria", "bebida", "beleza", "bermuda", "bigode", "boneca", "cabelo", "cabide", "caiu", "camelo", "camisa", "camiseta", "caneca", "caneta", "cantar", "carta", "casaco", "casamento", "casca", "cavalete", "cavalo", "cego", "celular", "cidade", "cinco", "cinema", "cocada", "comer", "computador", "deitar", "ditado", "elefante", "escola", "facial", "farofa", "favela", "festa", "fivela", "fofoca", "forma", "forno", "gaiola", "gaveta", "girafa", "goiaba", "goiabada", "gorila", "ideia", "iluminar", "jabuti", "janela", "javali", "jornal", "labial", "laranja", "leite", "lavantar", "lucas", "macaco", "maluco", "manga", "melado", "menino", "mercado", "modelo", "morno", "nanica", "navio", "noite", "noiva", "novela", "novelo", "nuvem", "paladino", "palito", "panela", "papai", "parede", "pedido", "peludo", "peneira", "peruca", "pomada", "pipoca", "porco", "porta", "pudim", "rabiola","raiva", "recado", "sacola", "sapato", "semana", "social", "sorte", "tabela", "tampa", "tapete", "tarde", "telefone","titia", "tomada", "tomate", "tucano", "vacina", "vestido", "vidro"]
    
    let nivel3 = ["abajur", "abelha", "abstrato", "aluguel", "aranha", "armadilha", "assado", "assassino", "atravessar", "avesso", "banheira", "banheiro", "banho", "baralho", "barriga", "bicicleta", "biscoito", "bochecha", "bolacha", "bolha", "brinquedo", "bruxa", "burro", "cachorro", "caixa", "caqui", "carregador", "carrinho", "carro", "casa", "cascavel", "castelo", "cereal", "chapeu", "chinelo", "chocolate", "chutar", "chuva", "chuveiro", "cinto", "compartilhar", "complementar", "conhecer", "corrida", "cortina", "cozinha", "descascar", "desenho", "emblema", "energia", "escova", "espantalho", "espelho", "esquilo", "estrela", "existir", "extintor", "fantasma", "feijoada", "fLoresta", "fogueira", "foguete", "folha", "garganta", "gravata", "guache", "guitarra", "homem", "hospital", "isqueiro", "jarra", "jiboia", "jipe", "lanche", "lateral", "linha", "lustre", "macarronada", "mexer", "mexerica", "morango", "mosquito", "mulher", "objeto", "olho", "ovelha", "padaria", "parafuso", "passageiro", "passarinho", "passeio", "peixe", "pequeno", "pernilongo", "peteca", "pilha", "porcelana", "quarto", "queijo", "rainha", "refrigerante", "risada", "rosa", "sabedoria", "sabonete", "salsicha", "sede", "selo", "sentir", "sino", "sinuca", "sorvete", "sossego", "submeter", "tecido", "teclado", "telha", "telhado", "tigela", "travesseiro", "trindade", "trinta", "unha", "varal", "vassoura", "viagem", "xadrez", "zebra"]
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    
    override init(size: CGSize)
    {
        super.init(size: size)
        
        //Fisica do Mundo
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0.0, 0.0)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("PausarBackground"), name: "PauseGameScene", object: nil)

       NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("continuar"), name: "DespauseGameScene", object: nil)
        
        
        //som.musicaDeFundo()
        
        moedinhas = moedas.integerForKey("Moedinhas")
        pontuacaoMaxima = highScore.integerForKey("Recorde")
        
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("addLetra"), userInfo: nil, repeats: true)
        
        // A primeira instancia da linha abaixo define o tempo de queda dos powerups
        
        _ = NSTimer.scheduledTimerWithTimeInterval(40, target: self, selector: Selector("addPowerUp"), userInfo: nil, repeats: true)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(5.5, target: self, selector: Selector("addMoedas"), userInfo: nil, repeats: true)
        
        FundoEscolhido()
        
        PersonagemEscolhido()
        
        addPalavra()
        
        adicionaVidas()
        
        som.musicaDeFundo()
        
        botaoPause.position = CGPointMake(CGRectGetMidX(self.frame)+420,CGRectGetMidY(self.frame)+330)
        botaoPause.setScale(0.5)
        botaoPause.zPosition = 5
        addChild(botaoPause)
        
        textoPontuacao = SKLabelNode(fontNamed:"Bubblegum")
        textoPontuacao.text = "Pontos"
        textoPontuacao.fontColor = UIColor(red: 0/255.0, green: 162.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        textoPontuacao.fontSize = 30
        textoPontuacao.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+330)
        self.addChild(textoPontuacao)
        
        textoPontos = SKLabelNode(fontNamed: "Qarmic")
        textoPontos.text = "\(pontos)"
        textoPontos.fontColor = SKColor.blackColor()
        textoPontos.fontSize = 25
        textoPontos.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+300)
        self.addChild(textoPontos)
        
        
        coreMotionManager.accelerometerUpdateInterval = 0.4
        
        if (coreMotionManager.accelerometerAvailable)
        {
            coreMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue())
                { (data, error) in
                
                if let _ = error
                {
                    print("Erro no CoreMotion")
                }
                else
                {
                    if data!.acceleration.y < 0
                    {
                        self.yAxisAcceleration = CGFloat(data!.acceleration.y)
                    }
                    else if data!.acceleration.y > 0
                    {
                        self.yAxisAcceleration = CGFloat(data!.acceleration.y)
                    }
                }
            }
        }
    }
    
    
    override func didSimulatePhysics()
    {
        if !ativoAcelerometro {
            if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight
            {
                personagem!.physicsBody!.velocity = CGVectorMake(yAxisAcceleration * velocidade,0)
            }
            else if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft
            {
                personagem!.physicsBody!.velocity = CGVectorMake(-yAxisAcceleration * velocidade, 0)
            }
        }
        else {
            if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight
            {
                personagem!.physicsBody!.velocity = CGVectorMake(-yAxisAcceleration * velocidade, 0)
            }
            else if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft
            {
                personagem!.physicsBody!.velocity = CGVectorMake(+yAxisAcceleration * velocidade, 0)
            }
        }
        
        if personagem.position.x > size.width + 25
        {
            personagem.position = CGPoint(x: -25, y: size.height / 2 - 300)
        }
        else if personagem.position.x < -25
        {
            personagem.position = CGPoint(x: size.width + 25, y: size.height / 2 - 300)
        }
    }
    
    func desativarPowerUp(){
        nomePowerUp.removeFromParent()
        ativo = false
        ativoAcelerometro = false
        ativoImune = false
        ativoDestaca = false
        velocidade = 700.0
        velocidadeLetras = 0
        piscando = false
    }
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        let nodeB = contact.bodyB.node!
        print(nodeB.name!, terminator: "")
        var letra = [""]
        
        for character in (nodeB.name!).characters
        {
            letra.append(String(character))
        }
        
        _ = array.count
        
        if letra[1] == array[contato]
        {
            self.letraAtingida = self.childNodeWithName(letra[1])
            som.tocaLetraCerta(letra[1])
            self.letraAtingida.alpha = 1.0
            self.letraAtingida.name = letra[1]+"1"
            self.anterior = letra[1]
            self.contato += 1

            if !ativo {
                pontos += 5
            }
            else{
                pontos += 10
            }
            textoPontos.text = "\(pontos)"
            if (self.contato > self.range)
            {
                range = 0
                self.removePalavra()
                self.contato = 1
                if !ativo{
                    pontos+=10
                }
                else {
                    pontos += 20
                }
                palavrasCertas += 1
                textoPontos.text = "\(pontos)"
                som.audioPlayFundo.pause()
                som.acertouPalavra()
                self.addPalavra()
                //Adicionar nivelamento
            }
        }
        else if (nodeB.name == "MoedaGameOver"){
            contMoedas+=1
        }
        else if (nodeB.name == "Acelerar5segundos")
        {
            velocidadeLetras = 1
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "Acelerar5segundos")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            som.playPowerUp()
            addChild(nomePowerUp)
            
        }
        else if (nodeB.name == "ApagaUmaLetra" && self.letraAtingida != nil) || (nodeB.name == "ApagaUmaLetra" && self.contato == 1)
        {
            som.playPowerUp()
            if self.contato != 1 && self.letraAtingida.name == self.anterior+"1"
            {
                self.letraAtingida.alpha = 0.5
                self.letraAtingida.name = self.anterior
                self.contato -= 1
            }
        }
        else if (nodeB.name == "GanhaUmaVida")
        {
            powerVidas()
            som.playPowerUp()

        }
        else if (nodeB.name == "CompletarApalavra")
        {
            som.playPowerUp()

            for (var i = contato; i <= range; i++){
                letra[1] = array[i]
                self.letraAtingida = self.childNodeWithName(letra[1])
                self.letraAtingida.name = letra[1]+"1"
                self.pontos+=5
            }
            range = 0
            contato = 1
            pontos += 5
            textoPontos.text = "\(pontos)"
            self.removePalavra()
            self.addPalavra()
        }
        else if (nodeB.name == "Desacelerar5segundos")
        {
            som.playPowerUp()
            velocidadeLetras = -1
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "Desacelerar5segundos")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            addChild(nomePowerUp)
        }
        else if (nodeB.name == "DestacaLetrasCertas")
        {
            som.playPowerUp()
            ativoDestaca = true
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "DestacaLetrasCertas")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            addChild(nomePowerUp)
        }
        else if (nodeB.name == "Ganha5pontos")
        {
            som.playPowerUp()
            self.pontos += 5
            textoPontos.text = "\(pontos)"
        }
        else if (nodeB.name == "ImuneAsLetrasErradasPor10Segundos")
        {
            som.playPowerUp()
            ativoImune = true
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "ImuneAsLetrasErradasPor10Segundos")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            addChild(nomePowerUp)
        }
        else if (nodeB.name == "InverterComandos")
        {
            som.playPowerUp()
            ativoAcelerometro = true
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "InverterComandos")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            addChild(nomePowerUp)
            
        }
        else if (nodeB.name == "MoveMaisDevagar5segundos")
        {
            som.playPowerUp()
            velocidade = 100.0
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "MoveMaisDevagar5segundos")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            addChild(nomePowerUp)
        }
        else if (nodeB.name == "MoveMaisRapido5segundos")
        {
            som.playPowerUp()
            velocidade = 2200.0
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "MoveMaisRapido5segundos")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            addChild(nomePowerUp)
        }
        else if (nodeB.name == "MultiplicadorDePontos")
        {
            som.playPowerUp()
            ativo = true
            terminaPowerUp()
            nomePowerUp = SKSpriteNode(imageNamed: "MultiplicadorDePontos")
            nomePowerUp.position = CGPoint(x:CGRectGetMidX(self.frame)-420, y:CGRectGetMidY(self.frame)+250)
            nomePowerUp.setScale(0.2)
            addChild(nomePowerUp)
        }
        else if (nodeB.name == "Perde5pontos")
        {
            som.playPowerUp()
            self.pontos -= 5
            textoPontos.text = "\(pontos)"
        }
        else if (nodeB.name == "PreencheUmaLetra")
        {
            som.playPowerUp()
            self.letraAtingida = self.childNodeWithName(array[contato])
            letra[1] = array[contato]
            self.letraAtingida = self.childNodeWithName(letra[1])
            self.letraAtingida.alpha = 1.0
            self.letraAtingida.name = letra[1]+"1"
            
            let a = array.count - 1
            print(a, terminator: "")
            if self.contato >= a
            {
                self.contato = 0
                self.pontos += 5
                self.removePalavra()
                self.textoPontos.text = "\(pontos)"
                self.som.audioPlayFundo.pause()
                self.som.acertouPalavra()
                self.addPalavra()
            }
            self.contato += 1
        }
        else
        {
            if (erros < 5 && !ativoImune)
            {
                switch erros
                {
                    case 0:
                        vida5.runAction(actionVidas)
                        break
                    case 1:
                        vida4.runAction(actionVidas)
                        break
                    case 2:
                        vida3.runAction(actionVidas)
                        break
                    case 3:
                        vida2.runAction(actionVidas)
                        break
                    default:
                        vida1.runAction(actionVidas)
                }
                erros += 1
                 _ = NSTimer.scheduledTimerWithTimeInterval(1.1, target: self, selector: Selector("removeVidas"), userInfo: nil, repeats: false)
            }
        }
        
        if erros < 5
        {
            som.audioPlayFundo.play()
        }
            
            nodeB.removeFromParent()
    }
    
    var teste = SKSpriteNode()
    
    func removeVidas(){
        switch erros
        {
        case 1:
            vida5.removeFromParent()
            break
        case 2:
            vida4.removeFromParent()
            break
        case 3:
            vida3.removeFromParent()
            break
        case 4:
            vida2.removeFromParent()
            break
        default:
            vida1.removeFromParent()
            gameOver()
            som.audioPlayFundo.stop()
            break
        }
    }
    
    func PausarBackground(){
        self.paused = true
    }
    
    func terminaPowerUp(){
        _ = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: Selector("proximoAoFim"), userInfo: nil, repeats: false)
        _ = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: Selector("desativarPowerUp"), userInfo: nil, repeats: false)
    }
    
    func proximoAoFim(){
        piscando = true
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("piscaPowerUp"), userInfo: nil, repeats: piscando)
    }
    var piscando = false
    
    func piscaPowerUp(){
        let action = SKAction.sequence([SKAction.scaleTo(0.2, duration: 0.5), SKAction.scaleTo(0.0, duration: 0.5)])
        if piscando{
            nomePowerUp.runAction(action)
        }
    }
    
    func dificuldade(){
        if palavrasCertas < 10{
            self.palavraDaVez(1)
        }
        else if palavrasCertas < 20{
            self.palavraDaVez(2)
        }
        else{
            self.palavraDaVez(3)
        }
    }
    
    func addPalavra()
    {
        self.dificuldade()
        
        for i in array
        {
            if i != ""
            {
                palavra = SKSpriteNode(imageNamed: i)
                palavra.position = CGPointMake(CGRectGetMidX(self.frame)-85+count, CGRectGetMidY(self.frame)+330)
                palavra.alpha = 0.5
                palavra.setScale(0.5)
                palavra.zPosition = 5
                palavra.name = i
                addChild(palavra)
                count += 65
            }
        }
        count = 0
    }
    
    func removePalavra()
    {
        for i in array
        {
            if i != ""
            {
                let a = self.childNodeWithName(i+"1")
                a?.removeFromParent()
            }
        }
        array = [""]
    }
    
    func PersonagemEscolhido()
    {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let a = defaults.integerForKey("personagem")
        
        if a == 0
        {
            personagem = jogadorNode(size: CGSize(width: 130, height: 130), personagem: "Auau")
        }
        else if a == 1
        {
            personagem = jogadorNode(size: CGSize(width: 130, height: 130), personagem: "Miau")
        }
        else if a == 2
        {
            personagem = jogadorNode(size: CGSize(width: 130, height: 150), personagem: "bolinha")
        }
        else if a == 3
        {
            personagem = jogadorNode(size: CGSize(width: 130, height: 130), personagem: "bigodinho")
        }
        personagem.position = CGPoint(x: size.width / 2, y: size.height / 2 - 300)
        self.addChild(personagem!)
    }
    
    func FundoEscolhido()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let b = defaults.integerForKey("fundoEscolhido")
        
        if b == 0
        {
            self.fundo = SKSpriteNode(imageNamed: "Fundo2")
        }
        else if b == 1
        {
            self.fundo = SKSpriteNode(imageNamed: "fundo4")
        }
        else if b == 2
        {
            self.fundo = SKSpriteNode(imageNamed: "Fundo3")
        }
        else if b == 3
        {
            self.fundo = SKSpriteNode(imageNamed: "Fundo1")
        }
        
        fundo.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundo.xScale = 0.5
        fundo.yScale = 0.5
        self.addChild(fundo)
    }
    
    func pausar()
    {
        self.paused = true
        pausado = true
        som.audioPlayFundo.pause()
        fundoEscurecido.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        fundoEscurecido.setScale(0.5)
        fundoEscurecido.zPosition = 10
        fundoPause.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        fundoPause.setScale(0.5)
        fundoPause.zPosition = 11
        self.botaoContinuar.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+80)
        self.botaoContinuar.setScale(0.5)
        self.botaoContinuar.zPosition = 11
        self.botaoSair.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-70)
        self.botaoSair.setScale(0.5)
        self.botaoSair.zPosition = 11
        self.addChild(fundoEscurecido)
        self.addChild(fundoPause)
        self.addChild(botaoContinuar)
        self.addChild(botaoSair)
    }
    
    func gameOver(){
        self.paused = true
        pausado = true
        gameAtivo = true
        self.addChild(fundoEscurecido)
        botaoPause.zPosition = 5
        fundoGameOver.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        fundoGameOver.setScale(0.5)
        fundoGameOver.zPosition = 11
        botaoJogar.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-50)
        botaoJogar.setScale(0.5)
        botaoJogar.zPosition = 11
        botaoMenu.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-140)
        botaoMenu.setScale(0.5)
        botaoMenu.zPosition = 11
        let moedaFinal = SKSpriteNode(imageNamed: "MoedaGameOver")
        moedaFinal.position = CGPointMake(CGRectGetMidX(self.frame)+250,CGRectGetMidY(self.frame)+40)
        moedaFinal.setScale(0.5)
        moedaFinal.zPosition = 12
        let valorMoedas = SKLabelNode(fontNamed: "Bubblegum")
        valorMoedas.text = "\(moedinhas)"
        valorMoedas.position = CGPointMake(CGRectGetMidX(self.frame)+210,CGRectGetMidY(self.frame)+28)
        valorMoedas.zPosition = 12
        valorMoedas.fontColor = UIColor(red: 179.0/255.0, green: 132/255.0, blue: 0/255.0, alpha: 1.0)
        let valorPontos = SKLabelNode(fontNamed: "Bubblegum")
        valorPontos.text = "\(pontos) pontos"
        valorPontos.position = CGPointMake(CGRectGetMidX(self.frame)-210,CGRectGetMidY(self.frame)+28)
        valorPontos.zPosition = 12
        valorPontos.fontColor = UIColor(red: 0/255.0, green: 162.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        let recorde = SKLabelNode(fontNamed: "Bubblegum")
        recorde.text = "Recorde: \(pontuacaoMaxima)"
        recorde.position = CGPointMake(CGRectGetMidX(self.frame)-210,CGRectGetMidY(self.frame)+150)
        recorde.zPosition = 12
        recorde.setScale(0.8)
        recorde.fontColor = UIColor(red: 0/255.0, green: 162.0/255.0, blue: 122.0/255.0, alpha: 1.0)

        moedasPlacar()
        self.addChild(fundoGameOver)
        self.addChild(botaoJogar)
        self.addChild(botaoMenu)
        self.addChild(moedaFinal)
        self.addChild(valorMoedas)
        self.addChild(valorPontos)
        self.addChild(recorde)
    }
    
    func continuar()
    {
        som.audioPlayFundo.play()
        fundoEscurecido.removeFromParent()
        fundoPause.removeFromParent()
        botaoContinuar.removeFromParent()
        botaoSair.removeFromParent()
        self.paused = false
        pausado = false

    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first as UITouch?
        let touchLocation = touch!.locationInNode(self)
        if(botaoPause.containsPoint(touchLocation)) && !pausado && !clicou{
            clicou = true
            clicouNoPause = true
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.5, duration: 0.15)])
            botaoPause.runAction(action)
            
            som.playAudioBotoesGeral()
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("pausar"), userInfo: nil, repeats: false)
            
        }
        else if (botaoContinuar.containsPoint(touchLocation) && pausado && !gameAtivo && clicou){
            clicou = false
            clicouNoPause = false
            self.paused = false
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.5, duration: 0.15)])
            self.botaoContinuar.runAction(action)
            
            som.playAudioBotoesGeral()
            _ = NSTimer.scheduledTimerWithTimeInterval(0.30, target: self, selector: Selector("continuar"), userInfo: nil, repeats: false)
        }
        else if (botaoSair.containsPoint(touchLocation) && pausado && !gameAtivo && clicou){
            clicou = false
            som.playAudioBotoesGeral()
            self.paused = false
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.5, duration: 0.15)])
            self.botaoSair.runAction(action)
            
            self.pausado = false
            _ = NSTimer.scheduledTimerWithTimeInterval(0.30, target: self, selector: Selector("chamaMenu"), userInfo: nil, repeats: false)
        }
        else if (botaoJogar.containsPoint(touchLocation) && pausado && gameAtivo){
            self.paused = false
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.5, duration: 0.15)])
            botaoJogar.runAction(action)
            
            som.playAudioBotoesGeral()
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("chamaGameScene"), userInfo: nil, repeats: false)
        }
        else if(botaoMenu.containsPoint(touchLocation) && pausado && gameAtivo){
            let action = SKAction.sequence([SKAction.scaleTo(0.4, duration: 0.15), SKAction.scaleTo(0.5, duration: 0.15)])
            botaoMenu.runAction(action)
            
            som.playAudioBotoesGeral()
            self.paused = false
            self.pausado = false
            _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("chamaMenu"), userInfo: nil, repeats: false)
        }
    }
    
    func chamaGameScene(){
        let transition = SKTransition()
        let cenarioMenu = GameScene(size: self.size)
        cenarioMenu.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioMenu, transition: transition)
    }
    
    func chamaMenu()
    {
        som.audioPlayFundo.stop()
        let transition = SKTransition()
        let cenarioMenu = Menu(size: self.size)
        cenarioMenu.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioMenu, transition: transition)
    }
    
    func addPowerUp()
    {
        if !pausado{
            self.power = arrayPowerUps[Int(arc4random_uniform(14))]
            let powerUp = PowerUps(size: CGSize(width: 120, height: 120), Power: self.power)
            powerUp.name = self.power
            powerUp.setScale(0.6)
            self.addChild(powerUp)
            powerUp.runPowerUpAction(size.height)
        }
    }
    
    func addMoedas(){
        
        if !pausado{
            let moedas = Moedas(size: CGSize(width: 40, height: 40), Moeda: "MoedaGameOver")
            moedas.name = "MoedaGameOver"
            moedas.setScale(0.5)
            self.addChild(moedas)
            moedas.runMoedaAction(size.height)
        }
    }
    
    func addLetra()
    {
        if !pausado
        {
            if flag < 10
            {
                if (self.contato > self.range)
                {
                    self.contato = 1
                }
                if (a==1)
                {
                    var sprite: String
                    let letraDaVez = self.childNodeWithName(self.array[contato])
                    let array=["b","c","d","f","a","g","h","i","u","j","k","l","m","e","o"]
    
                    sprite = array[Int(arc4random_uniform(10))]
    
                    if (!ativoDestaca){
                        let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite+sprite)
                        self.addChild(letra)
                        letra.checaVelocidade(velocidadeLetras)
                    }
                    else {
                        if letraDaVez?.name == sprite{
                            let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite)
                            self.addChild(letra)
                            letra.checaVelocidade(velocidadeLetras)
                        }
                        else{
                            let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite+sprite)
                            self.addChild(letra)
                            letra.checaVelocidade(velocidadeLetras)
                        }
                    }
                    self.a = 2
                    self.flag += 1
                }
                else
                {
                    var sprite: String
                    let array = ["n","p","o","q","e","r","s","t","u","v","w","x","y","z","a","i"]
    
                    let letraDaVez = self.childNodeWithName(self.array[contato])
                    sprite = array[Int(arc4random_uniform(11))]
    
                    if (!ativoDestaca){
                        let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite+sprite)
                        self.addChild(letra)
                        letra.checaVelocidade(velocidadeLetras)
                    }
                    else {
                        if letraDaVez?.name == sprite{
                            let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite)
                            self.addChild(letra)
                            letra.checaVelocidade(velocidadeLetras)
                        }
                        else{
                            let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite+sprite)
                            self.addChild(letra)
                            letra.checaVelocidade(velocidadeLetras)
                        }
                    }
                    self.a = 1
                    self.flag += 1
                }
            }
            else
            {
                var sprite: String
                
                
                for (var preRandom = arc4random()%3 ; preRandom > 3 ; preRandom++){

                    let array = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
                    
                    let letraDaVez = self.childNodeWithName(self.array[contato])
                    sprite = array[Int(arc4random_uniform(26))]
                    
                    if (!ativoDestaca){
                        let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite+sprite)
                        self.addChild(letra)
                        letra.checaVelocidade(velocidadeLetras)
                    }
                    else {
                        if letraDaVez?.name == sprite{
                            let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite)
                            self.addChild(letra)
                            letra.checaVelocidade(velocidadeLetras)
                        }
                        else{
                            let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite+sprite)
                            self.addChild(letra)
                            letra.checaVelocidade(velocidadeLetras)
                        }
                    }

                }
                
                _ = self.childNodeWithName(self.array[contato])
                sprite = self.array[contato]
                
                if (!ativoDestaca){
                    let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite+sprite)
                    self.addChild(letra)
                    letra.checaVelocidade(velocidadeLetras)
                }
                else {
                    let letra = Letras(size: CGSize(width: 120, height: 120), Letra: sprite)
                    self.addChild(letra)
                    letra.checaVelocidade(velocidadeLetras)
                    
                }
                self.flag = 0

            }
        }
    }
    
    func palavraDaVez(NivelAtual: Int)
    {
        if (NivelAtual == 1)
        {
            self.sorteada = nivel1[Int(arc4random_uniform(109))]

        }
        else if (NivelAtual == 2)
        {
            self.sorteada = nivel2[Int(arc4random_uniform(114))]
            print(sorteada, terminator: "")
        }
        else if (NivelAtual == 3)
        {
            self.sorteada = nivel3[Int(arc4random_uniform(128))]
        }
        
        for character in sorteada.characters
        {
            array.append(String(character))
            range+=1
        }
    }
    
    func adicionaVidas(){
        vida1.setScale(0.3)
        vida2.setScale(0.3)
        vida3.setScale(0.3)
        vida4.setScale(0.3)
        vida5.setScale(0.3)
        vida1.position = CGPoint(x:CGRectGetMidX(self.frame)-340, y:CGRectGetMidY(self.frame)+340)
        vida2.position = CGPoint(x:CGRectGetMidX(self.frame)-310, y:CGRectGetMidY(self.frame)+340)
        vida3.position = CGPoint(x:CGRectGetMidX(self.frame)-280, y:CGRectGetMidY(self.frame)+340)
        vida4.position = CGPoint(x:CGRectGetMidX(self.frame)-250, y:CGRectGetMidY(self.frame)+340)
        vida5.position = CGPoint(x:CGRectGetMidX(self.frame)-220, y:CGRectGetMidY(self.frame)+340)
        self.addChild(vida1)
        self.addChild(vida2)
        self.addChild(vida3)
        self.addChild(vida4)
        self.addChild(vida5)
    }
    
    func powerVidas(){
        if erros != 0 {
            switch erros{
            case 1:
                self.addChild(vida5)
                vida5.runAction(actionVidas2)
                break
            case 2:
                self.addChild(vida4)
                vida4.runAction(actionVidas2)
                break
            case 3:
                self.addChild(vida3)
                vida3.runAction(actionVidas2)
                break
            default:
                self.addChild(vida2)
                vida2.runAction(actionVidas2)
                break
            }
            erros-=1
        }
    }
    
    func moedasPlacar(){
        moedinhas = moedinhas + contMoedas
        moedas.setInteger(moedinhas, forKey: "Moedinhas")
        moedas.synchronize()
    }
    
    func salvarRecorde(){
        if (pontos > pontuacaoMaxima){
            pontuacaoMaxima = pontos
            highScore.setInteger(pontuacaoMaxima, forKey: "Recorde")
            highScore.synchronize()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(pausado && self.paused == false){
            self.paused = true
        }
        salvarRecorde()
    }
}
