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
 
 The settings manager is responsible for writing information to and from `settings.json` when running the Termina binary. It usually writes this file in the directory where the binary is executed.
 */
class SettingsManager {
    
    /**
     The player to read data from and save data to.
     */
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
            
            // Disable possible bypass of adding extra health
            if Double(jsonData["health"].string!)! >= 100.0 {
                thisPlayer.health = 100.0
                saveSettings()
            } else {
                thisPlayer.health = Double(jsonData["health"].string!)!
            }
            
            
            
            return true
            
        } else {
            myLogger.error("Player data not found.")
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
     Delete the settings.json file.
     
     Deleting settings by means of this function will make a copy in its parent directory and delete the existing one inside of the folder where Termina is run from.
     */
    func deleteSettings() {
        let jsonPath = try! Folder(path: "")
        
        try! jsonPath.file(named: "settings.json").copy(to: Folder(path: "../"))
        
        try! jsonPath.file(named: "settings.json").delete()
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
