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

