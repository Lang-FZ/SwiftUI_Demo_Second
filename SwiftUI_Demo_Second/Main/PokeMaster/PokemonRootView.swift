//
//  PokemonRootView.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/14.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct PokemonRootView: View {
    var body: some View {
        NavigationView {
            PokemonList().navigationBarTitle("宝可梦列表")
        }
    }
}

struct PokemonRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}
