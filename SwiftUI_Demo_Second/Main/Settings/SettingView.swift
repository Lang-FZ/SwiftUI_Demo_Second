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
                    selection: settingsBinding.checker.accountBehavior,
                    label: Text(""))
                {
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("电子邮箱", text: settingsBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .green : .red)
                
                SecureField("密码", text: settingsBinding.checker.password)
                
                if settings.checker.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.checker.verifyPassword)
                        .foregroundColor(settings.isPasswordValid ? .green : .red)
                }
                
                if settings.loginRequesting {
                    ActivityView()
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                } else {
                    Button(settings.checker.accountBehavior.text) {
                        self.store.dispatch(
                            .login(
                                email: self.settings.checker.email,
                                password: self.settings.checker.password)
                        )
                    }
                    .disabled(settings.checker.accountBehavior == .register && !settings.isPasswordValid)
                }
            } else {
                
                Text(settings.loginUser?.email ?? "")
                Button("注销") {
                    self.store.dispatch(
                        .logout
                    )
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
                self.store.dispatch(.clearCache)
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
