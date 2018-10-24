//
//  SettingsManager.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Handler for loading and saving settings to/from a JSON file (`settings.json`)
 */
class SettingsManager {
    
    var thisPlayer: Player!
    
    /**
     Load the player settings from a JSON file and assign the values to the Player object.
     
     - Returns: Boolean value of operation's success
     */
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
    
    /**
     Save the current values from the Player object to a JSON file.
     */
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
    
    /**
     Constructs the SettingsManager class.
     
     - Parameters:
        - who: the player to load data to and save data from
     */
    init(_ who: Player) {
        thisPlayer = who
    }
}
