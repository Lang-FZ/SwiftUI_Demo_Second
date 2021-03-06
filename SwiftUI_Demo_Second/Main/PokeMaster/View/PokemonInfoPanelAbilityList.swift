//
//  PokemonInfoPanelAbilityList.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/13.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

extension PokemonInfoPanel {
    
    struct AbilityList: View {
        
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                
                if abilityModels != nil {
                    
                    ForEach(abilityModels!) { ability in
                        
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
