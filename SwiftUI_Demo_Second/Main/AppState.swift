//
//  AppState.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/19.
//  Copyright © 2020 LFZ. All rights reserved.
//


struct AppState {
    var settings = Settings()
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
        var loginError: AppError?
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        
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


import Foundation

enum AppError: Error, Identifiable {
    
    var id: String { localizedDescription }
    
    case passwordWrong
}

extension AppError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .passwordWrong:    return "密码错误"
        }
    }
}

