//
//  GameScene.swift
//  PizzaBit12-12
//
//  Created by Ray Edward Kimbler on 12/12/22.
//

import SpriteKit

import CoreHaptics

class GameScene: SKScene {
    
    
    
    //MARK: DEFINE BUTTONS AND OTHER NODES IN THE SCENE
    var miniChef = ChefSprite()
    var buttonTomato = SKSpriteNode(imageNamed: "0tomato")
    var buttonMozzarella = SKSpriteNode(imageNamed: "0mozzarella")
    var buttonBasil = SKSpriteNode(imageNamed: "0basil")
    var buttonOil = SKSpriteNode(imageNamed: "0oil")
    var flow = SKSpriteNode(imageNamed: "flow")
    var clickIndicator = HitZoneSprite()
    var livesIndicator = SKLabelNode()
    var pointsLabel = SKLabelNode()
    var ingredientArray: [SKNode] = []
    var audioManager = AudioManager()
    var combo_multiplier: Int = 1
    var combo: Int = 0
    var level_multiplier: Int
    var points: Int = 0
    var music: String
    var lives: Int = 3
    var beat: [Double]
    var bar: Double
    var level_length: TimeInterval
    var background = SKSpriteNode()
    var isInvulnerable: Bool = false
    var currentPizzaStage = 1
    var comboLabel = SKLabelNode()
    var scoreSprite = SKSpriteNode(imageNamed: "PointsZone")
    
    var engine : CHHapticEngine?
    
    var pizzaSprite = SKSpriteNode(imageNamed: "PizzaStage1")
    
    init(music: String, beat: [Double], bar: Double, level_multiplier: Int, size: CGSize){
        self.music = music
        self.beat = beat
        self.bar = bar
        self.level_multiplier = level_multiplier
        self.livesIndicator = SKLabelNode(text: "Lives: \(lives)")
        self.pointsLabel = SKLabelNode(text: "Points: \(points) | Multiplier: \(combo_multiplier)")
        audioManager.startPlayer(messageAudioName: music)
        level_length = audioManager.player!.duration
        super.init(size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        //define button properties
        
        
        let buttonDefaultCoordinateY: Double = frame.midY * 0.3
        let buttonDefaultSize = CGSize(width: 64, height: 64)
        
        buttonTomato.position = CGPoint(x: frame.midX * 0.2, y: buttonDefaultCoordinateY)
        buttonTomato.name = "TOMATO"
        buttonTomato.size = buttonDefaultSize
        
        buttonMozzarella.position = CGPoint(x: frame.midX * 0.55, y: buttonDefaultCoordinateY)
        buttonMozzarella.name = "MOZZARELLA"
        buttonMozzarella.size = buttonDefaultSize
        
        buttonBasil.position = CGPoint(x: frame.midX * 1.45, y: buttonDefaultCoordinateY)
        buttonBasil.name = "BASIL"
        buttonBasil.size = buttonDefaultSize
        
        buttonOil.position = CGPoint(x: frame.midX * 1.8, y: buttonDefaultCoordinateY)
        buttonOil.name = "OIL"
        buttonOil.size = buttonDefaultSize
        
        livesIndicator.position = CGPoint(x: frame.midX * 0.5 , y: frame.midY * 1.5)
        livesIndicator.fontSize = CGFloat(8)
        livesIndicator.fontName = "Blocktopia"
        
        clickIndicator.position = CGPoint(x: frame.midX * 0.5, y: frame.midY)
        clickIndicator.name = "ClickIndicator"
        clickIndicator.size = CGSize(width: 32, height: 32)
        
        pointsLabel.position = CGPoint(x: frame.midX * 0.5 , y: frame.midY * 1.6)
        pointsLabel.fontSize = CGFloat(8)
        pointsLabel.fontName = "Blocktopia"
        pointsLabel.zPosition = 2
        
        comboLabel.position = CGPoint(x: frame.midX * 0.5, y: frame.midY * 1.8)
        comboLabel.fontSize = CGFloat(8)
        comboLabel.fontName = "Blocktopia"
        comboLabel.zPosition = 2
        
        scoreSprite.position = CGPoint(x: frame.midX * 0.48, y: frame.midY * 1.7)
        scoreSprite.size = CGSize(width: 96, height: 48)
        scoreSprite.zPosition = 1
        
        background.name = "Background"
        background.texture = SKTexture(imageNamed: "bkg0")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = frame.size
        background.zPosition = -2
        
        miniChef.position = CGPoint(x: frame.maxX * 0.13, y: frame.midY)
        miniChef.zPosition = CGFloat(1)
        miniChef.size = CGSize(width: 32, height: 32)
        
        flow.zPosition = -1
        flow.size = CGSize(width: frame.maxX, height: 48)
        flow.position = CGPoint(x: frame.midX, y: frame.midY)
        
        pizzaSprite.position = CGPoint(x: frame.midX, y: frame.midY * 0.3)
        pizzaSprite.size = CGSize(width: 80, height: 48)
        
        addChild(buttonTomato)
        addChild(buttonMozzarella)
        addChild(buttonBasil)
        addChild(buttonOil)
        addChild(clickIndicator)
        addChild(livesIndicator)
        addChild(pointsLabel)
        addChild(miniChef)
        addChild(background)
        addChild(flow)
        addChild(pizzaSprite)
        addChild(scoreSprite)
        addChild(comboLabel)
        spawnManager(beat: beat, bar: bar)
        prepareHaptics()
        Timer.scheduledTimer(withTimeInterval: level_length, repeats: false){ _ in
            self.audioManager.isOver = true
        }
        Timer.scheduledTimer(withTimeInterval: level_length/5, repeats: true){ _ in
            self.currentPizzaStage += 1
            self.pizzaSprite.texture = SKTexture(imageNamed: "PizzaStage\(self.currentPizzaStage)")
        }
        
    }
    //MARK: MANAGE THE INGREDIENT NODES
    //spawns notes at a fixed interval
    func spawnManager(beat: [Double], bar: Double){
        let move = SKAction.moveTo(x: 0, duration: bar)
        let timeIntervals: [Double] = beat
        let easyPattern: [Bool] = [true, false]
        let notes: [Ingredient.Kind] = [.oil, .mozzarella, .tomato, .basil]
        
        Timer.scheduledTimer(withTimeInterval: timeIntervals.randomElement()!, repeats: true){
            (_) in
            
            let ingredient = IngredientSprite(ingredientKind: notes.randomElement()!)
            ingredient.name = ingredient.ingredientName
            ingredient.position = CGPoint(x: self.frame.maxX, y: self.frame.midY)
            ingredient.run(move)
            self.addChild(ingredient)
            self.ingredientArray.append(ingredient)
            if easyPattern.randomElement()! {
                Timer.scheduledTimer(withTimeInterval: timeIntervals.randomElement()!/2, repeats: false){ _ in
                    let ingredient = IngredientSprite(ingredientKind: notes.randomElement()!)
                    ingredient.name = ingredient.ingredientName
                    ingredient.position = CGPoint(x: self.frame.maxX, y: self.frame.midY)
                    ingredient.run(move)
                    self.addChild(ingredient)
                    self.ingredientArray.append(ingredient)
                }
            }
        }
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        /*self.points += 0.02
        print(points)*/
        
        if audioManager.isOver == true {
            let scene: SKScene = GameOverScene(score: points, endMessage: "Level Complete!", endMusic: "The Greatest Chef", size: frame.size)
            self.view?.presentScene(scene)
        }
        for ingredient in ingredientArray {
            if ingredient.position.x <= 0 {
                let i = ingredientArray.firstIndex(of: ingredient)!
                ingredient.removeFromParent()
                ingredientArray.remove(at: i)
                if isInvulnerable == false {
                    lives -= 1
                    isInvulnerable = true
                    Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false){ _ in
                        self.isInvulnerable = false
                    }
                }
                combo = 0
                livesIndicator.text = "Lives: \(lives)"
            }
        }
        if combo >= 20 {
            combo_multiplier = 3
            if lives < 3 {
                lives = 3
                livesIndicator.text = "Lives: \(lives)"
            }
        } else if combo >= 10 {
            combo_multiplier = 2
        } else {
            combo_multiplier = 1
        }
        if lives <= 0 {
            livesIndicator.text = "You Lost :("
            audioManager.stopIt()
            let scene:SKScene = GameOverScene(score: points, endMessage: "You Failed...", endMusic: "Lost but not defeated", size: frame.size)
            self.view!.presentScene(scene)
        }
        comboLabel.text = "Multiplier \(combo_multiplier)X"
        pointsLabel.text = "Points: \(points)"
    }
    
    
    //MARK: DEFINE WHAT HAPPENS WHEN A BUTTON IS PRESSED
    //record button press
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            switch touchedNode.name {
            case "TOMATO":
                playIngredientHapticsFile("tomato")
                defineSuccess(buttonPressed: "Tomato")
            case "BASIL":
                playIngredientHapticsFile("basil")
                defineSuccess(buttonPressed: "Basil")
            case "MOZZARELLA":
                playIngredientHapticsFile("mozzarella")
                defineSuccess(buttonPressed: "Mozzarella")
            case "OIL":
                playIngredientHapticsFile("oil")
                defineSuccess(buttonPressed: "Oil")
            default:
                print("No button pressed!")
            }
        }
    }
    
    //checks if the correct button was pressed at the right moment
    func defineSuccess(buttonPressed: String){
        miniChef.createKickAnimation()
        miniChef.run(miniChef.kickAnimation)
        //obj is the array of nodes at the position of the click indicator
        let obj = nodes(at: clickIndicator.position)
        if obj.isEmpty == true {
            displayResult(resultText: "Miss!")
            combo = 0
            if isInvulnerable == false {
                lives -= 1
                isInvulnerable = true
                Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false){ _ in
                    self.isInvulnerable = false
                }
            }
            livesIndicator.text = "Lives: \(lives)"
            return
        }
        
        if obj.first!.name == buttonPressed{
            print(obj)
            guard let i = ingredientArray.firstIndex(of: obj.first!) else { return }
            combo += 1
            //objIt is a copy of the left-most ingredient created to run the explosion animation
            let objIt = obj.first as? IngredientSprite
            let explosion = objIt?.buildExplosion()
            obj.first?.removeFromParent()
            objIt?.run(explosion!){
                objIt!.removeFromParent()
            }
            addChild(objIt!)
            
            
            ingredientArray.remove(at: i)
            points += 5 * combo_multiplier
            //self.pointsLabel.text = "Points: " + String(format: "%.0f", points) + " | Multiplier: \(combo_multiplier)"
            displayResult(resultText: "Perfect!")
            return
        }
        combo = 0
        displayResult(resultText: "Miss!")
        if isInvulnerable == false {
            lives -= 1
            isInvulnerable = true
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false){ _ in
                self.isInvulnerable = false
            }
        }
        livesIndicator.text = "Lives: \(lives)"
        return
    }
    
    func displayResult(resultText: String){
        var successDisplay: SKLabelNode?
        successDisplay = SKLabelNode(text: resultText)
        successDisplay!.fontSize = CGFloat(8)
        successDisplay!.position = CGPoint(x: frame.midX * 0.4, y: frame.midY * 1.2)
        successDisplay?.fontName = "Blocktopia"
        addChild(successDisplay!)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){ _ in
            successDisplay!.removeFromParent()
            successDisplay = nil
        }
    }
    func prepareHaptics( ){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            engine = try CHHapticEngine()
            try engine?.start()
        }catch let error{
            print("\(error)")
        }
    }
    
    func playIngredientHapticsFile(_ theIngredientName : String){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            let pattern = createPatternFromAHAP(theIngredientName)
            let player = try engine?.makePlayer(with: pattern!)
            try player?.start(atTime: 0)
        }catch let error{
            print("\(error)")
        }
    }
    
    func createPatternFromAHAP(_ filename: String) -> CHHapticPattern? {
        // Get the URL for the pattern in the app bundle.
        let patternURL = Bundle.main.url(forResource: filename, withExtension: "ahap")!
        
        do {
            // Read JSON data from the URL.
            let patternJSONData = try Data(contentsOf: patternURL, options: [])
            
            // Create a dictionary from the JSON data.
            let dict = try JSONSerialization.jsonObject(with: patternJSONData, options: [])
            
            if let patternDict = dict as? [CHHapticPattern.Key: Any] {
                // Create a pattern from the dictionary.
                return try CHHapticPattern(dictionary: patternDict)
            }
        } catch let error {
            print("Error creating haptic pattern: \(error)")
        }
        return nil
    }
    
    
    
}
