//
//  Sample.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/7.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Foundation

#if DEBUG

extension Pokemon {
    static func sample(id: Int) -> Pokemon {
        return FileHelper.loadBundleJSON(file: "pokemon-\(id)")
    }
}
 
extension PokemonSpecies {
    static func sample(url: URL) -> PokemonSpecies {
        return FileHelper.loadBundleJSON(file: "pokemon-species-\(url.extractedID!)")
    }
}

extension Ability {
    
    static func sample(url: URL) -> Ability {
        sample(id: url.extractedID!)
    }
    
    static func sample(id: Int) -> Ability {
        return FileHelper.loadBundleJSON(file: "ability-\(id)")
    }
}

extension PokemonViewModel {
    
    static var all: [PokemonViewModel] = {
        (1...30).map { id in
            let pokemon = Pokemon.sample(id: id)
            let species = PokemonSpecies.sample(url: pokemon.species.url)
            return PokemonViewModel(pokemon: pokemon, species: species)
        }
    }()
    
    static let samples: [PokemonViewModel] = [
        sample(id: 1),
        sample(id: 2),
        sample(id: 3)
    ]
    
    static func sample(id: Int) -> PokemonViewModel {
        let pokemon = Pokemon.sample(id: id)
        let species = PokemonSpecies.sample(url: pokemon.species.url)
        return PokemonViewModel(pokemon: pokemon, species: species)
    }
}

extension AbilityViewModel {
    
    static func sample(pokemonID: Int) -> [AbilityViewModel] {
        Pokemon.sample(id: pokemonID).abilities.map {
            AbilityViewModel(ability: Ability.sample(url: $0.ability.url))
        }
    }
}

#endif
