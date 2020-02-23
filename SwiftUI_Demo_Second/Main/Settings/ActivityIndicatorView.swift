//
//  ActivityIndicatorView.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/23.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ActivityView>) -> UIView {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ActivityView>) {
        
        let activity = UIActivityIndicatorView()
        activity.startAnimating()
        uiView.addSubview(activity)
        
        NSLayoutConstraint.activate([
            activity.centerYAnchor.constraint(equalTo: uiView.centerYAnchor)
        ])
    }
}

