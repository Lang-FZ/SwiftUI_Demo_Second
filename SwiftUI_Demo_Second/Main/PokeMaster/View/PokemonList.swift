//
//  PokemonList.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/13.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon) //separator
//        }
        
        ScrollView {
            
            TextField.init("搜索", text: $store.appState.pokemonList.searchValue)
                .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
            
            ForEach(store.appState.pokemonList.allPokemonsByID) { pokemon in
                
                PokemonInfoRow(
                    model: pokemon,
                    expanded: self.store.appState.pokemonList.selectionState.expandingIndex == pokemon.id
                )
                .onTapGesture {
                    
                    self.store.dispatch(
                        .toggleListSelection(index: pokemon.id)
                    )
                    self.store.dispatch(
                        .loadAbilities(pokemon: pokemon.pokemon)
                    )
                }
            }
        }
//        .overlay(
//            VStack {
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom)
//        )
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
