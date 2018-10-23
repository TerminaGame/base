//
//  SettingsManager.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

class SettingsManager {
    
    var thisPlayer: Player!
    
    func loadSettings() -> Bool {
        let jsonPath = try! Folder(path: "")
        
        if (jsonPath.containsFile(named: "settings.json")) {
            let jsonDataFromFile = try! jsonPath.file(named: "settings.json").readAsString()
            
            let jsonData = JSON.init(parseJSON: jsonDataFromFile)
            
            thisPlayer.name = jsonData["name"].string!
            thisPlayer.level = Int(jsonData["level"].string!)
            thisPlayer.experience = Int(jsonData["progress"].string!)
            thisPlayer.health = Double(jsonData["health"].string!)!
            
            return true
            
        } else {
            print("[E] Player data not found.")
            return false
        }
    }
    
    func saveSettings() {
        let jsonPath = try! Folder(path: "")
        try! jsonPath.createFile(named: "settings.json", contents: """
{
    "name": "\(thisPlayer.name)",
    "level": "\(thisPlayer.level ?? 1)",
    "progress": "\(thisPlayer.experience ?? 0)",
    "health": "\(thisPlayer.health)"
}
""")
    }
    
    init(_ who: Player) {
        thisPlayer = who
    }
}
