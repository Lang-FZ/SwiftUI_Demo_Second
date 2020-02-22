//
//  SettingView.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/13.
//  Copyright © 2020 LFZ. All rights reserved.
//

import SwiftUI

struct SettingView: View {

    @EnvironmentObject var store : Store
    
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    
    var body: some View {
        
        Form {
            accountSection
            optionSection
            actionSection
        }
        .alert(item: settingsBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var accountSection: some View {
        
        Section(header: Text("账户")) {
            
            if settings.loginUser == nil {
                
                Picker(
                    selection: settingsBinding.accountBehavior,
                    label: Text(""))
                {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("电子邮箱", text: settingsBinding.email)
                
                SecureField("密码", text: settingsBinding.password)
                
                if settings.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.verifyPassword)
                }
                
                if settings.loginRequesting {
                    Text("登录中...")
                } else {
                    Button(settings.accountBehavior.text) {
                        self.store.dispatch(
                            .login(
                                email: self.settings.email,
                                password: self.settings.password)
                        )
                    }
                }
            } else {
                
                Text(settings.loginUser?.email ?? "")
                Button("注销") {
                    print("注销")
                }
            }
        }
    }
    
    var optionSection: some View {
        
        Section(header: Text("选项")) {
            
            Toggle(isOn: settingsBinding.showEnglishName) {
                Text("显示英文名")
            }
            
            Picker.init(selection: settingsBinding.sorting, label: Text("排序方式")) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            
            Toggle(isOn: settingsBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
        }
    }
    
    var actionSection: some View {
        
        Section() {
            
            Button("清空缓存") {
                print("清空缓存")
            }
            .font(.subheadline)
            .foregroundColor(.red)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store()
        store.appState.settings.sorting = .color
        return SettingView().environmentObject(store)
    }
}
