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

print("""
    Termina \(version)
    Copyright © 2018 Marquis Kurt. All rights reserved.
    """)

// Construct a player and command interpreter.
let myPlayer = Player("player")
let command = CommandInterpreter()

// Construct a settings manager to load data and attempt to locate a settings file.
let vm = SettingsManager(myPlayer)
if !vm.loadSettings() {                 // If the settings file is missing, ask the player to create a new player account.
    print("Enter a name to continue: ")
    myPlayer.name = readLine()!
    vm.saveSettings()
    
    print("\n")
    command.parseCommand("help", Room(myPlayer, nil), vm)    // Automatically display the 'help' command so new players know of all the commands.
    print("\n")
} else {                                // If the settings file is found, greet the player and assume that they know the controls.
    print("Welcome back to Termina, \(myPlayer.name). We've been waiting for you.\n")
    command.parseCommand("aboutself", Room(myPlayer, nil), vm)
}

// Always keep creating a new room until the room is destroyed.
// This is how new rooms generate.
while true {
    //TODO: Break this loop when level reaches the maximum level to initiate a boss fight.
    var theDarkRoom = Room(myPlayer, nil)
    
    // If the player's level is 420 or greater, break out of this loop.
    if myPlayer.level >= 420 {
        break
    }
    
    while theDarkRoom.isDestroyed == false {
        if theDarkRoom.isDestroyed == true {
            theDarkRoom = Room(myPlayer, nil)
        }
        print("\nWhat would you like to do? Type a command:")
        command.parseCommand(readLine(strippingNewline: true)!, theDarkRoom, vm) // Get the player's input and parse the command into the interpreter.
    }
}

// This code usually gets executed when the player has reached the sufficient level.
// In this case, this is where the boss battle with Termina occurs.
print("Well, haven't you managed to get yourself here?")
print("X")

while myPlayer.level >= 420 {
    let termina = Termina()
    let terminaRoom = Room(myPlayer, termina)
    
    print("\nWhat would you like to do? Type a command:")
    command.parseCommand(readLine(strippingNewline: true)!, terminaRoom, vm)
    termina.insult()
}
