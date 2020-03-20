//
//  AppAction.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/21.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Foundation

enum AppAction {
    
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
    case logout
    case clearCache
    
    case emailValid(valid: Bool)
    case passwordValid(valid: Bool)
    
    case loadPokemons
    case loadPokemonsDone(
        result: Result<[PokemonViewModel], AppError>
    )
    
    case toggleListSelection(index: Int?)
    case togglePanelPresenting(presenting: Bool)
    
    case loadAbilities(pokemon: Pokemon)
    case loadAbilitiesDone(
        result: Result<[AbilityViewModel], AppError>
    )
}

