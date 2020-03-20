//
//  PokemonInfoPanel.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/13.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    
    @EnvironmentObject var store: Store
    
    let model: PokemonViewModel
    var abilities: [AbilityViewModel] {
        store.appState.pokemonList.abilityViewModels(for: model.pokemon) ?? []
    }
    
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(
                model: model,
                abilityModels: abilities
            )
        }
        .padding(
            EdgeInsets(
                top: 12,
                leading: 30,
                bottom: 30,
                trailing: 30
            )
        )
        .blurBackground(style: .systemMaterial)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
}

extension PokemonInfoPanel {
    
    struct Header: View {
        
        let model: PokemonViewModel
        
        var body: some View {
            
            HStack(spacing: 18) {
                
                pokemonIcon
                nameSpecies
                verticalDivider
                
                VStack(spacing: 12) {
                    bodyStatus
                    typeInfo
                }
            }
        }
        
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        var nameSpecies: some View {
            
            VStack(spacing: 10) {
                
                VStack {
                    
                    Text(model.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(model.color)
                    
                    Text(model.nameEN)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(model.color)
                }
                
                Text(model.genus)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color.gray)
            }
            .frame(maxHeight: 68)
        }
        
        var verticalDivider: some View {
            
            RoundedRectangle(cornerRadius: 1)
                .frame(width: 1, height: 44)
                .foregroundColor(Color(hex: 0x000000, alpha: 0.1))
//                .opacity(0.1)
        }
        
        var bodyStatus: some View {
            
            VStack(alignment: .leading) {
            
                HStack() {
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.height)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
                
                HStack() {
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text(model.weight)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
            }
        }
        
        var typeInfo: some View {
            
            HStack() {
                
                ForEach(model.types) { t in
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 7)
                            .fill(t.color)
                            .frame(width: 36, height: 14)
                        Text(t.name)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
    }
}
