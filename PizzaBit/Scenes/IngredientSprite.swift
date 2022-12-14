//
//  GameScene.swift
//  PizzaBit12-12
//
//  Created by Ray Edward Kimbler on 12/12/22.
//

import SpriteKit
//MARK: GENERIC CLASS TO DEFINE THE ANIMATION OF ANY INGREDIENT SPRITE
class IngredientSprite: SKSpriteNode {
    //take any ingredient and get its frames
    var ingredientKind: Ingredient.Kind
    var ingredientName: String { ingredientKind.name }
    var ingredientNameExplosion: String = ""
    private var ingredientFrames: [SKTexture] = []
    let defaultSize: CGSize = CGSize(width: 32, height: 32)
    

    
    init(ingredientKind: Ingredient.Kind){
        //specify the ingredient and animate the sprite
        self.ingredientKind = ingredientKind
        super.init(texture: nil, color: .clear, size: defaultSize)
        buildIngredient()
        animateIngredient()
        self.ingredientNameExplosion = self.ingredientName + "-explosion"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: ANIMATIONS
    private func buildIngredient() {
        let ingredientAnimatedAtlas = SKTextureAtlas(named: ingredientName)
        var ingredientBufferFrames: [SKTexture] = []
        let numImages = ingredientAnimatedAtlas.textureNames.count
        for i in 1..<numImages+1 {
            let ingredientTextureName = "\(ingredientName)\(i)"
            ingredientBufferFrames.append(ingredientAnimatedAtlas.textureNamed(ingredientTextureName))
        }
        ingredientFrames = ingredientBufferFrames
        
        let firstFrameTexture = ingredientFrames[1]
        self.texture = firstFrameTexture
        self.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    func animateIngredient() {
        let animation = SKAction.animate(with: ingredientFrames, timePerFrame: ingredientKind.timePerFrame)
        self.run(SKAction.repeatForever(animation), withKey: "\(ingredientKind.rawValue)key")
    }

    func buildExplosion() -> SKAction{
      
        let ingredientAnimatedAtlas = SKTextureAtlas(named: ingredientNameExplosion)
        var ingredientBufferFrames: [SKTexture] = []
       
        let numImages = ingredientAnimatedAtlas.textureNames.count
        for i in 1..<numImages+1 {
            let ingredientTextureName = ingredientNameExplosion + "\(i)"
            
            ingredientBufferFrames.append(ingredientAnimatedAtlas.textureNamed(ingredientTextureName))
        }
        let ingredientFramesExplosion = ingredientBufferFrames
        
        let firstFrameTexture = ingredientFramesExplosion[1]
        self.texture = firstFrameTexture
        self.position = CGPoint(x: frame.midX, y: frame.midY)
        let animation = SKAction.animate(with: ingredientFramesExplosion, timePerFrame: ingredientKind.timePerFrame)
        return animation
    }
    
}
