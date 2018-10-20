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

let introSequence = [
    "Welcome to Termina.",
    "You awake to find yourself trapped in a large facility.",
    "You take a look in a narby mirror to examine yourself.",
    "It seems as if you've forgotten who you are.",
    "Please select who you are: (Claris | Henry)."
]

for line in introSequence {
    print(line)
    sleep(1)
}

let playerName = readLine()!
//if (playerName != "Claris" || playerName != "Henry") {
//    print("Hmm... maybe you really have forgotten who you are. You should go back to sleep.")
//    exit(1)
//}

let myPlayer = Player(playerName)

let command = CommandInterpreter()

print("\n")
command.parseCommand("help", Room(myPlayer))
print("\n")

while true {
    var theDarkRoom = Room(myPlayer)
    
    while theDarkRoom.isDestroyed == false {
        if theDarkRoom.isDestroyed == true {
            theDarkRoom = Room(myPlayer)
        }
        print("What would you like to do?")
        command.parseCommand(readLine(strippingNewline: true)!, theDarkRoom)
    }
}
