//
//  main.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//
import Foundation

// Get essential data about the game
let version = "1.0.0beta1"

// Display the "splash" screen and copyright information.
print("""
    Termina \(version)
    Copyright © 2018 Marquis Kurt. All rights reserved.
    """)

// Construct a player, command interpreter, and logger.
// These will get used constantly throughout the game.
let myPlayer = Player("player")
let command = CommandInterpreter()
let myLogger = Logger()

myLogger.logToFile("Starting a new session...", "info")

// Construct a settings manager to load data and attempt to locate a settings file.
let vm = SettingsManager(myPlayer)
myLogger.logToFile("Attempting to load settings...", "info")

// If the settings file is missing, ask the player to create a new player account.
if !vm.loadSettings() {
    myLogger.info("Creating a new settings file in this directory...")
    print("Enter a name to continue: ")
    myPlayer.name = readLine()!
    vm.saveSettings()
    myLogger.logToFile("New player data with name \(myPlayer.name) saved in settings.json.", "info")
    
    // Automatically display the 'help' command so new players know of all the commands.
    print("\n")
    command.parseCommand("help", Room(myPlayer, nil, command), vm)
    print("\n")
}

// If the settings file is found, greet the player and assume that they know the controls.
else {
    print("Welcome back to Termina, \(myPlayer.name). We've been waiting for you.\n")
    command.parseCommand("aboutself", Room(myPlayer, nil, nil), vm)
}

// Always keep creating a new room until the room is destroyed or the player level is
// high enough to break out of the loop and fight the boss.
while true {
    //TODO: Break this loop when level reaches the maximum level to initiate a boss fight.
    var theDarkRoom = Room(myPlayer, nil, command)
    myLogger.logToFile("New room generated.", "info")
    
    // If the player's level is 420 or greater, break out of this loop.
    if myPlayer.level >= 420 {
        break
    }
    
    // Loop infinitely until the player leaves the room, then go back to the main loop.
    while !theDarkRoom.isDestroyed {
        if theDarkRoom.isDestroyed {
            theDarkRoom = Room(myPlayer, nil, command)
        }
        
        // Get the player's input and parse the command into the interpreter.
        print("\nWhat would you like to do? Type a command:")
        command.parseCommand(readLine(strippingNewline: true)!, theDarkRoom, vm)
    }
}

// This code usually gets executed when the player has reached the sufficient level.
// In this case, this is where the boss battle with Termina occurs.

//TODO: Add Termina's pre-battle dialogue here.

// Start looping while the level is sufficient to fight Termina.
while myPlayer.level >= 420 {
    
    // Add Termina as a Monster to a new room.
    let termina = Termina()
    let terminaRoom = Room(myPlayer, termina, command)
    
    // Keep looping infinitely until the player is able to leave the room
    while !terminaRoom.isDestroyed {
        // Let Termina insult the player before taking a new command.
        termina.insult()
        
        // Get the player's input and parse the command.
        print("\nWhat would you like to do? Type a command:")
        command.parseCommand(readLine(strippingNewline: true)!, terminaRoom, vm)
    }
    
    // If the player has left the room, break this loop infinitely.
    if terminaRoom.isDestroyed {
        break
    }
}
