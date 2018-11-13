//
//  Arguments.swift
//  termina-base
//
//  Created by Marquis Kurt on 11/13/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Check for any arguments that the user might have passed when running
 Termina.
 */
func checkArgs() {
    for arg in CommandLine.arguments {
        switch arg {
        
        // Checks for Endless Mode.
        case "--endless":
            runEndlessModeFromCommandLine = true
            myLogger.logToFile("Running in Endless Mode...", "info")
            break
        
        // Checks for a reset request from the player.
        // This can be useful if the player wants to start the game
        // fresh without deleting their settings.json file.
        case "--reset":
            myLogger.logToFile("Resetting player file...", "info")
            myPlayer.level = 1
            myPlayer.experience = 0
            myPlayer.health = 100
            vm.saveSettings()
            break
        
        // Checks to see if player just wants to report
        // the game version without opening the game.
        case "--version":
            print(fullBuildId)
            exit(0)
            break
            
        case "--help":
            print("""
                Termina v.\(version)
                
                Passable Arguments:
                - endless: Runs the game in endless mode, ignoring the player's level.
                - reset: Resets the player back to the very beginning and starts the game.
                - version: Prints the full build ID of Termina.
                - help: Prints this page.

                """)
            exit(0)
            break
        
        default:
            break
        }
    }
}
