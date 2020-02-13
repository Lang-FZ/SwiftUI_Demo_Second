//
//  PokemonSpecies.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/4.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct PokemonSpecies: Codable {

    struct Color: Codable {
        
        enum Name: String, Codable {
            case black, blue, brown, gray, green, pink, purple, red, white, yellow
            var color: SwiftUI.Color { SwiftUI.Color("pokemon-\(rawValue)") }
        }
        
        let name: Name
    }
    
    struct Name: Codable, LanguageTextEntry {
        
        let language: Language
        let name: String
        
        var text: String { name }
    }
    
    struct FlavorTextEntry: Codable, LanguageTextEntry {
        
        let language: Language
        let flavorText: String
        
        var text: String { flavorText }
    }
    
    struct Genus: Codable, LanguageTextEntry {
        
        let language: Language
        let genus: String
        
        var text: String { genus }
    }
    
    let color: Color
    let names: [Name]
    let genera: [Genus]
    let flavorTextEntries: [FlavorTextEntry]
}
