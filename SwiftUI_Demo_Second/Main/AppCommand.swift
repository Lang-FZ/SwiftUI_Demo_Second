//
//  AppCommand.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/21.
//  Copyright © 2020 LFZ. All rights reserved.
//
import Combine

protocol AppCommand {
    func execute(in store: Store)
}

struct LoginAppCommand: AppCommand {
     
    let email: String
    let password: String
    
    func execute(in store: Store) {
        
        _ = LoginRequest(
            email: email,
            password: password
        ).publisher
            .sink(
                receiveCompletion: { complete in
                    
                    if case .failure(let error) = complete {
                        
                        store.dispatch(
                            .accountBehaviorDone(result: .failure(error))
                        )
                    }
                },
                receiveValue: { user in
                    
                    store.dispatch(
                        .accountBehaviorDone(result: .success(user))
                    )
                }
        )
    }
}

