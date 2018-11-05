//
//  NPC.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Non-player character class.
 
 The NPC is a docile entity that cna interact with the player and provide information. The `Player` class does have the ability to attack an NPC and kill it, though this is highly discouraged. The NPC also parses monologues and perform actions with them accordingly.
 */
class NPC: Entity {
    
    /**
     The monologue that the NPC can say.
     */
    var monologue = [""]
    
    /**
     Immediately kill the NPC (not recommended).
     */
    override func takeDamage(_ amount: Double) {
        health = 0
    }
    
    override func saySomething(_ what: String?) {
        if what != nil {
            super.saySomething(what ?? "Help me.")
        } else {
            super.saySomething(Monologue().randomMonologuesNPC.randomElement() ?? "Help me.")
        }
    }
    
    /**
     Say the respective monologue for the NPC line by line. Pauses are distributed porportionally to the lines.
     
     Monologues can use special strings or escape sequences to manipulate how the monologue is displayed.
     
     - Adding `"PAUSE"` as an element will prompt the user to press Enter before continuing.
     - Adding `"/hold"` to the string element will cause the interpreter to pause after the line is displayed for three seconds.
     
     - Parameters:
        - instant: Whether to display all lines instantly (Bool) instead of line by line
     */
    func sayMonologue(instant: Bool) {
        for line in monologue {
            if line == "PAUSE" {
                print("Press Enter to continue.".bold())
                let _ = readLine()!
            } else {
                if (line.range(of: "/hold") != nil) {
                    let strippedLine = line.replacingOccurrences(of: "/hold", with: "")
                    print("\(name.bold().foregroundColor(colorType)): \(strippedLine)")
                } else {
                    print("\(name.bold().foregroundColor(colorType)): \(line)")
                }
                if !instant {
                    if (line.range(of: "/hold") != nil) {
                        usleep(3000000)
                    } else {
                        usleep(useconds_t(50000 * line.count))
                    }
                }
            }
        }
        monologue = [""]
    }
    
    /**
     Construct the NPC class.
     
     - Parameters:
        - myName: Name of the NPC.
     */
    init(_ myName: String) {
        super.init(myName, "NPC", 100.0, TerminalColor.cyan1)
    }
}
