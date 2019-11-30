//
//  main.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//
import Foundation
import ColorizeSwift

// Construct all of the important objects we need for
// the game to run.
let myPlayer = Player("player")
let command = CommandInterpreter()
let myLogger = Logger()
let vm = SettingsManager(myPlayer)
var runEndlessModeFromCommandLine = false
var hardcoreMode = false

// Check all command arguments that could be passed through.
// Some commands may cause the program to quit before going
// through, so it must be checked before the game actually
// starts.
checkArgs()

// Display the "splash" screen and copyright information.
print("""
    Termina \(version)
    \(copyright)
    Type \("license".bold()) for more details.
    Made with ❤️
    
    """.foregroundColor(TerminalColor.orange3))

// Let players know if they are running in Endless Mode or Hardcore Mode.
if runEndlessModeFromCommandLine {
    print("You're running in \("Endless Mode".bold()).".foregroundColor(TerminalColor.orange1))
} else if hardcoreMode {
    print("You're running in \("Hardcore Mode".bold()).".red())
}
// Silently log that a new session has started. These silent logs appear everywhere so that
// the user has a better understanding of what is going on. They are stored in termlog.txt when
// the user exits the game (if the user asks for this log).
myLogger.logToFile("Starting a new session...", "info")

// Construct a settings manager to load data and attempt to locate a settings file.
myLogger.logToFile("Attempting to load settings...", "info")

// If the settings file is missing, ask the player to create a new player account.
if !vm.loadSettings() {
    myLogger.info("Creating a new settings file in this directory...")
    print("Enter a name to continue: ")
    myPlayer.name = readLine()!
    vm.saveSettings()
    myLogger.logToFile("New player data with name \(myPlayer.name) saved in settings.json.", "info")
    
    // Create the starting room for player to interact with the NPC.
    let craig = NPC("Craig")
    craig.monologue = Monologue().firstGameMonologue
    let storyJumpStart = StartRoom(myPlayer, craig)
    myLogger.logToFile("Tutorial room generated.", "info")
    
    // Clear the console and have Craig start his monologue.
    command.parseCommand("clear", storyJumpStart, vm, skipCommandLogging: true)
    command.parseCommand("talk", storyJumpStart, vm, skipCommandLogging: true)
    
    // Immediately move to the next room after finishing.
    command.parseCommand("leave", storyJumpStart, vm, skipCommandLogging: true)
}

// If the settings file is found, display their profile information.
else {
    command.parseCommand("whoami", Room(myPlayer, nil, nil, nil), vm, skipCommandLogging: true)
}

// Always keep creating a new room until the room is destroyed or the player level is
// high enough to break out of the loop and fight the boss.
while true {
    var theDarkRoom = Room(myPlayer, nil, command, nil)
    myLogger.logToFile("New room generated.", "info")
    
    // If the player's level is 420 or greater, break out of this loop.
    // This check will fail if the player passes the 'endless' parameter
    // into Termina before running it.
    if myPlayer.level >= 420 && runEndlessModeFromCommandLine == false {
        break
    }
    
    // Loop infinitely until the player leaves the room, then go back to the main loop.
    while !theDarkRoom.isDestroyed {
        if theDarkRoom.isDestroyed {
            theDarkRoom = Room(myPlayer, nil, command, nil)
            myLogger.logToFile("New room generated.", "info")
        }
        
        // Get the player's input and parse ift accordingly.
        command.getCommandAndParse(whichRoom: theDarkRoom, settings: vm, skipCommandLogging: false)
    }
}

// This code usually gets executed when the player has reached the sufficient level.
// In this case, this is where the boss battle with Termina occurs.

// Start looping while the level is sufficient to fight Termina.
while myPlayer.level >= 420 && runEndlessModeFromCommandLine == false {
    
    // Add Termina as a Monster to a new room.
    let termina = Termina()
    let finalPotion = Potion("Super Hotfix", myPlayer)
    finalPotion.maximumUse = 25
    finalPotion.currentUse = 25
    finalPotion.effect = 25
    let terminaRoom = Room(myPlayer, termina, command, finalPotion)
    
    
    // Clear the console again.
    command.parseCommand("clear", terminaRoom, vm, skipCommandLogging: true)
    
    // Say pre-battle dialogue before starting the fight.
    termina.speakBeforeFighting()
    
    command.parseCommand("ls", terminaRoom, vm, skipCommandLogging: true)
    
    // Keep looping infinitely until the player is able to leave the room
    while !terminaRoom.isDestroyed {
        
        if terminaRoom.myAttackSequence?.enemy != nil {
            // Let Termina insult the player before taking a new command.
            termina.insult()
        }
        
        command.getCommandAndParse(whichRoom: terminaRoom, settings: vm, skipCommandLogging: false)
    }
    
    // If the player has left the room, break this loop infinitely.
    if terminaRoom.isDestroyed {
        if termina.health == 0.0 {
            command.parseCommand("clear", terminaRoom, vm, skipCommandLogging: true)
            termina.parseMonologue(Monologue().terminaPostBattleMonologue)
        }
        myLogger.info("Congratulations! The game is now over.")
        myLogger.askForLogBeforeExiting()
        break
    }
}
