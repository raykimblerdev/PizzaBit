//
//  GameOverScene.swift
//  PizzaBit12-12
//
//  Created by Ray Edward Kimbler on 13/12/22.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var retryLabel = SKLabelNode()
    var menuLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        menuLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        menuLabel.text = "Go back to menu"
        menuLabel.name = "MENU"
        
        addChild(menuLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            switch touchedNode.name {
            case "MENU":
                let scene: SKScene = MenuScene(size: frame.size)
                self.view?.presentScene(scene)
            default:
                print("nothing")
            }
        }
    }
}
