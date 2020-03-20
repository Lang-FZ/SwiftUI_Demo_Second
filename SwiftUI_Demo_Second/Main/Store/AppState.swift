//
//  AppState.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/19.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Combine
import Foundation

struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
}

extension AppState {
    
    struct Settings {
        
        // MARK: AccountBehavior
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?

        var loginRequesting: Bool = false
        var isEmailValid: Bool = false
        var isPasswordValid: Bool = false
        var loginError: AppError?
        var checker = AccountChecker()
        
        class AccountChecker {
            
            @Published var accountBehavior = AccountBehavior.login
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                
                let remoteVerify = $email
                    .debounce(
                        for: .milliseconds(500),
                        scheduler: DispatchQueue.main
                )
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        
                        let validEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        
                        switch (validEmail, canSkip) {
                            
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                }
                
                let emailLocalValid = $email.map { $0.isValidEmailAddress }
                let canSkipRemoteVerify = $accountBehavior.map { $0 == .login }
                
                return Publishers.CombineLatest3(
                    emailLocalValid,
                    canSkipRemoteVerify,
                    remoteVerify
                )
                    .map { $0 && ($1 || $2) }
                    .eraseToAnyPublisher()
            }
            
            var isPasswordValid: AnyPublisher<Bool, Never> {
                
                let passwordVerify = $password
                    .debounce(
                        for: .milliseconds(500),
                        scheduler: DispatchQueue.main
                )
                    .removeDuplicates()
                    .flatMap { password -> AnyPublisher<String, Never> in
                        Just(password).eraseToAnyPublisher()
                }
                
                let verifyPasswordVerify = $verifyPassword
                    .debounce(
                        for: .milliseconds(500),
                        scheduler: DispatchQueue.main
                )
                    .removeDuplicates()
                    .flatMap { verifyPassword -> AnyPublisher<String, Never> in
                        Just(verifyPassword).eraseToAnyPublisher()
                }
                
                return passwordVerify.combineLatest(verifyPasswordVerify).map { $0 != "" && $0 == $1 }.eraseToAnyPublisher()
            }
        }
        
        // MARK: Sorting
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        
        @UserDefaultsStorage(key: "showEnglishName", value: true)
        var showEnglishName: Bool
        
//        @UserDefaultsStorage(key: "sorting", value: Sorting.id)
        var sorting = Sorting.id
        
        @UserDefaultsStorage(key: "showFavoriteOnly", value: false)
        var showFavoriteOnly: Bool
    }
}

protocol EnumText {
    var text: String { get }
}

extension AppState.Settings.Sorting: EnumText {
    
    var text: String {
        
        switch self {
        case .id:       return "ID"
        case .name:     return "名字"
        case .color:    return "颜色"
        case .favorite: return "最爱"
        }
    }
}

extension AppState.Settings.AccountBehavior {
    
    var text: String {
        
        switch self {
        case .register: return "注册"
        case .login:    return "登录"
        }
    }
}

extension AppState {
    
    struct PokemonList {
        
        struct SelectionState {
            
            var expandingIndex: Int? = nil
            var panelIndex: Int? = nil
            var panelPresented = false
            
            func isExpanding(_ id: Int) -> Bool {
                expandingIndex == id
            }
        }
        
        @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
        var pokemons: [Int: PokemonViewModel]?
        @FileStorage(directory: .cachesDirectory, fileName: "abilities.json")
        var abilities: [Int: AbilityViewModel]?
        
        var loadingPokemons = false
        var loadListError = false

        var searchValue: String = ""
        var selectionState = SelectionState()
        
        var allPokemonsByID: [PokemonViewModel] {
            
            guard let pokemons = pokemons?.values else {
                return []
            }
            return pokemons.sorted { $0.id < $1.id }
        }
        
        func abilityViewModels(
            for pokemon: Pokemon
        ) -> [AbilityViewModel]? {
            
            guard let abilities = abilities else { return nil }
            return pokemon.abilities.compactMap { abilities[$0.ability.url.extractedID!] }
        }
    }
}


enum AppError: Error, Identifiable {
    
    var id: String { localizedDescription }
    
    case passwordWrong
    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .passwordWrong:                return "密码错误"
        case .networkingFailed(let error):  return error.localizedDescription
        }
    }
}

