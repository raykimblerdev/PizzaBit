//
//  IngredientModel.swift
//  PizzaBit12-12
//
//  Created by Ray Edward Kimbler on 12/12/22.
//

import Foundation

struct Ingredient: Identifiable {
    var id = UUID()
    var type: Kind
    
    var imgName: String { "0" + type.rawValue }
    var sfx: String { type.rawValue }
    var haptic: String { type.rawValue }
    
    enum Kind: String, CaseIterable {
        case tomato
        case basil
        case oil
        case mozzarella
        
        var name: String { rawValue.capitalized }
        var timePerFrame: Double {
            switch self {
            case .tomato:
                return 0.08
            case .basil:
                return 0.04
            case .oil:
                return 0.21
            case .mozzarella:
                return 0.15
            }
        }
        
        var size: CGFloat {
            switch self {
            case .mozzarella, .tomato:
                return 32
            case .basil:
                return 64
            case .oil:
                return 128
            }
        }
    }
}
