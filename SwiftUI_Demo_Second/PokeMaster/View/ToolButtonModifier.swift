//
//  ToolButtonModifier.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/12.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct ToolButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
    }
}
