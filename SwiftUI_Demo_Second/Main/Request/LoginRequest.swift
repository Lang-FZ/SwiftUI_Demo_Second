//
//  LoginRequest.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/21.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Foundation
import Combine

struct LoginRequest {
    
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError> {
        
        Future { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                
                if self.password == "password" {
                    
                    let user = User(
                        email: self.email,
                        favoritePokemonIDs: []
                    )
                    promise(.success(user))
                    
                } else {
                    
                    promise(.failure(.passwordWrong))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

