//
//  EmailCheckingRequest.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/25.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    
    let email: String
    
    var publisher: AnyPublisher<Bool, Never> {
        
        Future<Bool, Never> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                
                if self.email.lowercased() == "446003664@qq.com" {
                    promise(.success(false))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
