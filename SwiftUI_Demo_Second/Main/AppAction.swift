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
}

