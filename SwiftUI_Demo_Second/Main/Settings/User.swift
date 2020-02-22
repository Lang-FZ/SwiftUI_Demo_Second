//
//  User.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/21.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var email: String
    var favoritePokemonIDs: Set<Int>
    
    func isFvoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
}

