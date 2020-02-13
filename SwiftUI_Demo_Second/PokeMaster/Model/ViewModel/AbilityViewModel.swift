//
//  AbilityViewModel.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/6.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct AbilityViewModel: Codable, Identifiable {

    let ability: Ability
    
    init(ability: Ability) {
        self.ability = ability
    }
    
    var id: Int { ability.id }
    var name: String { ability.names.CN }
    var nameEN: String { ability.names.EN }
    var descriptionText: String { ability.flavorTextEntries.CN.newlineRemove }
    var descriptionTextEN: String { ability.flavorTextEntries.EN.newlineRemove }
}

extension AbilityViewModel: CustomStringConvertible {
    var description: String {
        "AbilityViewModel - \(id) - \(self.name)"
    }
}
