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
    
    /**
     Immediately kill the NPC (not recommended).
     */
    override func takeDamage(_ amount: Double) {
        health = 0
    }
    
    /**
     Say the respective monologue for the NPC line by line. If `"PAUSE"` is listed anywhere, prompt the user to hit the Enter key before continuing.
     
     - Parameters:
        - instant: Whether to display all lines instantly (Bool) instead of line by line
     */
    func sayMonologue(instant: Bool) {
        for line in monologue {
            if line == "PAUSE" {
                print("Press Enter to continue.".bold())
                let _ = readLine()!
            } else {
                print("\(name.bold().cyan()): \(line)")
                if !instant {
                    usleep(useconds_t(50000 * line.count))
                }
            }
        }
        monologue = [""]
    }
    
    /**
        Say a random line from a list of dialogues.
     */
    func saySomething() {
        print("\(name.bold().cyan()): \((Monologue().randomMonologuesNPC.randomElement() ?? "Help me."))")
    }
    
    /**
     Construct the NPC class.
     
     - Parameters:
        - myName: Name of the NPC.
     */
    init(_ myName: String) {
        super.init(myName, "NPC", 100.0)
    }
}
