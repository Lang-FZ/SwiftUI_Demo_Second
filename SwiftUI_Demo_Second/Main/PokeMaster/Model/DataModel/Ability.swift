//
//  Ability.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/4.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Foundation

struct Ability: Codable {

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
    
    let id: Int
    
    let names: [Name]
    let flavorTextEntries: [FlavorTextEntry]
}
