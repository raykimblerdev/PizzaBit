//
//  ChefSprite.swift
//  PizzaBit
//
//  Created by Ray Edward Kimbler on 14/12/22.
//

import SpriteKit

class ChefSprite: SKSpriteNode {
    
    var idleAtlasName: String = "MiniChef"
    var kickAtlasName: String = "Chef-Kick"
    var idleAnimation = SKAction()
    var kickAnimation = SKAction()
    
    func createIdleAnimation(){
        let ingredientAnimatedAtlas = SKTextureAtlas(named: idleAtlasName)
        var ingredientBufferFrames: [SKTexture] = []
        let numImages = ingredientAnimatedAtlas.textureNames.count
        for i in 1..<numImages+1 {
            let ingredientTextureName = "\(idleAtlasName)\(i)"
            ingredientBufferFrames.append(ingredientAnimatedAtlas.textureNamed(ingredientTextureName))
        }
        //let firstFrameTexture = ingredientBufferFrames[1]
        let idleAction = SKAction.animate(with: ingredientBufferFrames, timePerFrame: 0.25)
        idleAnimation = SKAction.repeatForever(idleAction)
    }
    
    func createKickAnimation(){
        let ingredientAnimatedAtlas = SKTextureAtlas(named: kickAtlasName)
        var ingredientBufferFrames: [SKTexture] = []
        let numImages = ingredientAnimatedAtlas.textureNames.count
        for i in 1..<numImages+1 {
            let ingredientTextureName = "\(kickAtlasName)\(i)"
            ingredientBufferFrames.append(ingredientAnimatedAtlas.textureNamed(ingredientTextureName))
        }
        let firstFrameTexture = ingredientBufferFrames[1]
        self.texture = firstFrameTexture
        kickAnimation = SKAction.animate(with: ingredientBufferFrames, timePerFrame: 0.1)
       
    }
    
    init() {
        super.init(texture: nil, color: .clear, size: CGSize(width: 64, height: 64))
        createIdleAnimation()
        self.run(idleAnimation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
