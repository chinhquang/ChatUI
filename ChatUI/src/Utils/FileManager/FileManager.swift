//
//  FileManager.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/24/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit

let kFileManager = FileManager.shared
class FileManager {
    static let shared = FileManager()
    
    private init(){}
    
    func readJsonFromMainBundle(jsonFile : String) -> Any? {
        do {
            if let file = Bundle.main.url(forResource: jsonFile, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    return object
                } else if let object = json as? [Any] {
                    // json is an array
                   
                    return object
                } else {
                    print("JSON is invalid")
                    return nil
                }
            } else {
                print("no file")
                return nil
            }
        } catch {
            print(error.localizedDescription)

            return nil
        }
    }
}
