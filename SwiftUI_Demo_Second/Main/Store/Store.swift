//
//  Store.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/19.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Combine
import Foundation

class Store: ObservableObject {
    
    @Published var appState = AppState()
    private var disposeBag = DisposeBag()
    
    init() {
        setupObservers()
    }
    
    func setupObservers() {
        
        appState.settings.checker.isEmailValid.sink { isValid in
            self.dispatch(.emailValid(valid: isValid))
        }.add(to: disposeBag)
        
        appState.settings.checker.isPasswordValid.sink { isValid in
            self.dispatch(.passwordValid(valid: isValid))
        }.add(to: disposeBag)
    }
    
    func dispatch(_ action: AppAction) {
        
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        
        if let command = result.1 {

            #if DEBUG
            print("[COMMAND]: \(command)")
            #endif
            command.execute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        
        var appState = state
        var appCommand: AppCommand?
        
        switch action {
            
        case .login(let email, let password):
            guard !appState.settings.loginRequesting else {
                break
            }
            appState.settings.loginRequesting = true
            
            appCommand = LoginAppCommand(
                email: email,
                password: password
            )
        case .accountBehaviorDone(let result):
            appState.settings.loginRequesting = false
            switch result {
            case .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                appState.settings.loginError = error
            }
        case .logout:
            appState.settings.loginRequesting = false
            appState.settings.loginUser = nil
            appState.settings.loginError = nil
            
        case .emailValid(let valid):
            appState.settings.isEmailValid = valid
        case .passwordValid(let valid):
            appState.settings.isPasswordValid = valid
            
        case .loadPokemons:
            appState.pokemonList.loadListError = false
            if appState.pokemonList.loadingPokemons {
                break
            }
            appState.pokemonList.loadingPokemons = true
            appCommand = LoadPokemonsCommand()
        case .loadPokemonsDone(let result):
            appState.pokemonList.loadingPokemons = false
            switch result {
            case .success(let models):
                appState.pokemonList.pokemons =
                    Dictionary(
                        uniqueKeysWithValues: models.map { ($0.id, $0) }
                )
            case .failure(let error):
                print(error)
                appState.pokemonList.loadListError = true
            }
            
        case .toggleListSelection(let index):
            if appState.pokemonList.selectionState.expandingIndex == index {
                appState.pokemonList.selectionState.expandingIndex = nil
                appState.pokemonList.selectionState.panelPresented = false
            } else {
                appState.pokemonList.selectionState.expandingIndex = index
                appState.pokemonList.selectionState.panelIndex = index
            }
        case .togglePanelPresenting(let presenting):
            appState.pokemonList.selectionState.panelPresented = presenting
            
        case .loadAbilities(let pokemon):
            appCommand = LoadAbilitiesCommand(pokemon: pokemon)
        case .loadAbilitiesDone(let result):
            switch result {
            case .success(let loadedAbilities):
                var abilities = appState.pokemonList.abilities ?? [:]
                for ability in loadedAbilities {
                    abilities[ability.id] = ability
                }
                appState.pokemonList.abilities = abilities
            case .failure(let error):
                print(error)
            }

        case .clearCache:
            appState.settings.loginUser = nil
            appState.pokemonList.pokemons = nil
            appState.pokemonList.abilities = nil
            appState.settings.showEnglishName = true
            appState.settings.showFavoriteOnly = false
        }
        
        return (appState, appCommand)
    }
}

