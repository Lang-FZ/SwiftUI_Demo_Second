//
//  PokemonList.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/13.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    
    @State var expandingIndex: Int?
    @State var searchValue: String = ""
    
    var body: some View {
        
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon) //separator
//        }
        
        ScrollView {
            
            TextField.init("搜索", text: $searchValue)
                .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
            
            ForEach(PokemonViewModel.all) { pokemon in
                
                PokemonInfoRow(
                    model: pokemon,
                    expanded: self.expandingIndex == pokemon.id
                )
                .onTapGesture {
                    
                    self.expandingIndex =  self.expandingIndex == pokemon.id ? (nil) : (pokemon.id)
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
