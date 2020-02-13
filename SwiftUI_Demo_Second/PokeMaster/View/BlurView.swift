//
//  BlurView.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/13.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: uiView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: uiView.widthAnchor)
        ])
    }
}

extension View {
    
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        
        ZStack {
            
            BlurView(style: style)
            self
        }
    }
}

