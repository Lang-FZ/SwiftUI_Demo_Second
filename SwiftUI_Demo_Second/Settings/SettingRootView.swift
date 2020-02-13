//
//  SettingRootView.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/14.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView().navigationBarTitle("设置")
        }
    }
}

struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
