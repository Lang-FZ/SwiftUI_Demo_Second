//
//  FileStorage.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/21.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Foundation

@propertyWrapper
struct FileStorage<T: Codable> {
    
    var value: T?
    
    let directory: FileManager.SearchPathDirectory
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory, fileName: String) {
        
        value = try? FileHelper.loadJSON(
            from: directory,
            fileName: fileName
        )
        
        self.directory = directory
        self.fileName = fileName
    }
    
    var wrappedValue: T? {
    
        set {
            
            value = newValue
            if let value = newValue {
                try? FileHelper.writeJSON(
                    value,
                    to: directory,
                    fileName: fileName)
            } else {
                try? FileHelper.delete(
                    from: directory,
                    fileName: fileName)
            }
        }
        
        get { value }
    }
}

@propertyWrapper
struct UserDefaultsStorage<T: Codable> {
    
    let key: String
    var value: T
    
    init(key: String, value: T) {
        
        self.key = key
        
        if let userDefaultsValue = UserDefaults.standard.value(forKey: key) {
            self.value = userDefaultsValue as! T
        } else {
            self.value = value
        }
    }
    
    var wrappedValue: T {
    
        set {
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize()
        }
        
        get {
            value
        }
    }
}
/*
@propertyWrapper
struct UserDefaultsStorageEnum<EnumText: Codable> {
    
    let key: String
    var value: EnumText
    
    init(key: String, value: EnumText) {
        
        self.key = key
        
        if let userDefaultsValue = UserDefaults.standard.value(forKey: key) as? String {
//            self.value = userDefaultsValue as! EnumText
        } else {
//            self.value = value
        }
    }
    
    var wrappedValue: EnumText {
        
        set {
            
        }
        
        get {
            value
        }
    }
}
*/
