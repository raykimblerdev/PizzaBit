//
//  GameOverScene.swift
//  PizzaBit12-12
//
//  Created by Ray Edward Kimbler on 13/12/22.
//

import SpriteKit

class GameOverScene: SKScene {
    
    
    var endMessage: String
    var endMusic: String
    var resultLabel = SKLabelNode()
    var menuLabel = SKLabelNode()
    var background = SKSpriteNode(imageNamed: "bkg0")
    var audioManager = AudioManager()
    
    init(endMessage: String, endMusic: String, size: CGSize) {
        self.endMessage = endMessage
        self.endMusic = endMusic
        self.audioManager.startPlayer(messageAudioName: endMusic)
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMove(to view: SKView) {
        
        resultLabel.position = CGPoint(x: frame.midX, y: frame.midY * 1.5)
        resultLabel.text = endMessage
        resultLabel.fontSize = 8
        resultLabel.fontName = "Blocktopia"
        
        menuLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        menuLabel.text = "Go back to menu"
        menuLabel.fontSize = 14
        menuLabel.fontName = "Blocktopia"
        menuLabel.name = "MENU"
        
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = frame.size
        background.zPosition = -1
        
        addChild(resultLabel)
        addChild(background)
        addChild(menuLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            switch touchedNode.name {
            case "MENU":
                audioManager.stopIt()
                let scene: SKScene = MenuScene(size: frame.size)
                self.view?.presentScene(scene)
            default:
                print("nothing")
            }
        }
    }
}
