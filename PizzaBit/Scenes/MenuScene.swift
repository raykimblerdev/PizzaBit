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
    

    
    override func didMove(to view: SKView) {
        easyButton = SKLabelNode(text: "Easy")
        easyButton.name = "Easy"
        mediumButton = SKLabelNode(text: "Medium")
        mediumButton.name = "Medium"
        hardButton = SKLabelNode(text: "Hard")
        hardButton.name = "Hard"
        
        easyButton.position = CGPointMake(frame.midX, frame.midY)
        mediumButton.position = CGPointMake(frame.midX, frame.midY-25)
        hardButton.position = CGPointMake(frame.midX, frame.midY-50)
        
        addChild(easyButton)
        addChild(mediumButton)
        addChild(hardButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            switch touchedNode.name {
            case "Easy":
                print("Easy Pressed")
                let scene:SKScene = GameScene(music: "Pizza Easy", beat: 0.6667 * 2, bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: frame.maxX, height: frame.maxY))
                self.view?.presentScene(scene)
            case "Medium":
                print("Medium Pressed")
                let scene:SKScene = GameScene(music: "Pizza Medium", beat: 0.5 * 2, bar: 2, level_multiplier: 2, size: CGSize(width: frame.maxX, height: frame.maxY))
                self.view?.presentScene(scene)
            case "Hard":
                print("Hard Pressed")
                let scene:SKScene = GameScene(music: "PERFECTIONIST", beat: 0.4, bar: 1.6, level_multiplier: 3, size: CGSize(width: frame.maxX, height: frame.maxY))
                self.view?.presentScene(scene)
            default:
                print("nothing")
            }
            
        }
    }
    
}
