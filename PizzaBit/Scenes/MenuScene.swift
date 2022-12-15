//
//  MenuScene.swift
//  PizzaBit12-12
//
//  Created by Ray Edward Kimbler on 12/12/22.
//

import SpriteKit



class MenuScene: SKScene {
    
    var easyButton = SKLabelNode()
    var mediumButton = SKLabelNode()
    var hardButton = SKLabelNode()
    var chefMenu = ChefSprite()
    var background = SKSpriteNode()
    var audioManager = AudioManager()
    
    override func didMove(to view: SKView) {
        
        audioManager.startPlayer(messageAudioName: "Aube Is A Chef!")
        
        easyButton = SKLabelNode(text: "Easy")
        easyButton.name = "Easy"
        easyButton.fontName = "Blocktopia"
        mediumButton = SKLabelNode(text: "Medium")
        mediumButton.name = "Medium"
        mediumButton.fontName = "Blocktopia"
        hardButton = SKLabelNode(text: "Hard")
        hardButton.fontName = "Blocktopia"
        hardButton.name = "Hard"
        
        background.name = "Background"
        background.texture = SKTexture(imageNamed: "bkg0")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = frame.size
        background.zPosition = -1
        
        chefMenu.position = CGPoint(x: frame.midX * 0.5, y: frame.midY)
        
        
        easyButton.position = CGPointMake(frame.midX * 1.2, frame.midY)
        mediumButton.position = CGPointMake(frame.midX * 1.2, frame.midY-25)
        hardButton.position = CGPointMake(frame.midX * 1.2, frame.midY-50)
        
        addChild(easyButton)
        addChild(mediumButton)
        addChild(hardButton)
        addChild(chefMenu)
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            switch touchedNode.name {
            case "Easy":
                print("Easy Pressed")
                audioManager.stopIt()
                let scene:SKScene = GameScene(music: "Pizza_Easy", beat: [0.6667 * 2] , bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: frame.maxX, height: frame.maxY))
                self.view?.presentScene(scene)
            case "Medium":
                print("Medium Pressed")
                audioManager.stopIt()
                let scene:SKScene = GameScene(music: "Pizza_Medium", beat: [0.5 * 2] , bar: 2, level_multiplier: 2, size: CGSize(width: frame.maxX, height: frame.maxY))
                self.view?.presentScene(scene)
            case "Hard":
                audioManager.stopIt()
                print("Hard Pressed")
                let scene:SKScene = GameScene(music: "PERFECTIONIST", beat: [0.4], bar: 1.6, level_multiplier: 3, size: CGSize(width: frame.maxX, height: frame.maxY))
                self.view?.presentScene(scene)
            default:
                print("nothing")
            }
            
        }
    }
    
}
