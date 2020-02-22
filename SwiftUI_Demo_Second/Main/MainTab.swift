//
//  MainTab.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/18.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct MainTab: View {
    
    var body: some View {
    
        TabView {
            
            PokemonRootView().tabItem {
                
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }
            
            SettingRootView().tabItem {
                
                Image(systemName: "gear")
                Text("设置")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
