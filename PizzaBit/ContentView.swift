//
//  ContentView.swift
//  PizzaBit
//
//  Created by Ray Edward Kimbler on 14/12/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var scene: SKScene {
        let scene = MenuScene()
        scene.size = CGSize(width: 256, height: 144)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        
        SpriteView(scene: self.scene)
            .ignoresSafeArea()
    }
}
