//
//  PokemonRootView.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/14.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct PokemonRootView: View {
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        
        NavigationView {
            
            if store.appState.pokemonList.loadListError {
                
                Button(action: {
                    self.store.dispatch(.loadPokemons)
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color(hex: 0x8E8E93))
                        Text("Retry")
                            .font(.headline)
                            .foregroundColor(Color(hex: 0x8E8E93))
                    }
                }
                .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: 0x8E8E93), lineWidth: 1)
                )
                
            } else {
                
                if store.appState.pokemonList.pokemons == nil {
                    
                    Text("Loading...").onAppear {
                        self.store.dispatch(.loadPokemons)
                    }
                } else {
                    
                    PokemonList()
                        .navigationBarTitle("宝可梦列表")
                }
            }
        }
    }
}

struct PokemonRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}
