//
//  PokeMasterView.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/1/30.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct PokeMasterView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct PokeMasterView_Previews: PreviewProvider {
    static var previews: some View {
        PokeMasterView()
            .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
            .previewDisplayName("iPhone XR")
    }
}
