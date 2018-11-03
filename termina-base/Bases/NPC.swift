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
 */
class NPC: Entity {
    
    var monologue = [""]
    var quip: String
    
    /**
     Immediately kill the NPC (not recommended).
     */
    override func takeDamage(_ amount: Double) {
        health = 0
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
                    print("\(name.bold().cyan()): \(strippedLine)")
                } else {
                    print("\(name.bold().cyan()): \(line)")
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
        Say a random line picked from a list of dialogues.
     */
    func saySomething() {
        print("\(name.bold().cyan()): \(quip)")
    }
    
    /**
     Construct the NPC class.
     
     - Parameters:
        - myName: Name of the NPC.
     */
    init(_ myName: String) {
        quip = Monologue().randomMonologuesNPC.randomElement() ?? "Help me."
        super.init(myName, "NPC", 100.0)
    }
}
