//
//  main.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//
import Foundation

let version = "1.0.0beta2"

print("""
    Termina \(version)
    Copyright © 2018 Marquis Kurt. All rights reserved.
    """)

let myPlayer = Player("player")
let command = CommandInterpreter()

let vm = SettingsManager(myPlayer)
if !vm.loadSettings() {
    print("Enter a name to continue: ")
    myPlayer.name = readLine()!
    vm.saveSettings()
    
    print("\n")
    command.parseCommand("help", Room(myPlayer), vm)
    print("\n")
} else {
    print("Welcome back to Termina, \(myPlayer.name). We've been waiting for you.")
}

while true {
    var theDarkRoom = Room(myPlayer)
    
    while theDarkRoom.isDestroyed == false {
        if theDarkRoom.isDestroyed == true {
            theDarkRoom = Room(myPlayer)
        }
        print("What would you like to do?")
        command.parseCommand(readLine(strippingNewline: true)!, theDarkRoom, vm)
    }
}
