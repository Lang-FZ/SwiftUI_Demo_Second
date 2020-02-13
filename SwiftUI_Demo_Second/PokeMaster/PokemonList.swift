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
    
    var body: some View {
        
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon) //separator
//        }
        
        ScrollView {
            
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
        
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
