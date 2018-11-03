//
//  Termina.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Main Termina villain. Subclass of `Monster` class.
 
 Termina is the primary villain of the game. This class provides special properties such as speaking and insulting, usually reserved for NPCs.
 */
class Termina: Monster {
    
    /**
     Provides an instance of the Monologue class.
     */
    var speaker = Monologue()
    
    /**
     Insult the player with a line of dialogue.
     */
    func insult() {
        print("Termina: \(speaker.terminaDerogatoryMonologue.randomElement() ?? "You're wasting my time.")")
    }
    
    /**
     Speak pre-battle dialogue.
     
     This function borrows elements from NPCs in parsing the monologue.
     */
    func speakBeforeFighting() {
        for line in speaker.terminaPreBattleMonologue {
            if line == "PAUSE" {
                print("Press Enter to continue.".bold())
                let _ = readLine()!
            } else {
                if (line.range(of: "/hold") != nil) {
                    let strippedLine = line.replacingOccurrences(of: "/hold", with: "")
                    print("\(name.bold().cyan()): \(strippedLine)")
                    usleep(3000000)
                } else {
                    print("\(name.bold().cyan()): \(line)")
                    usleep(useconds_t(50000 * line.count))
                }
            }
        }
    }
    
    /**
     Damage Termina by an amount and print a painful scream.
     
     - Parameters:
        - amount: The amount of damage to give to Termina
     */
    override func takeDamage(_ amount: Double) {
        super.takeDamage(amount)
        print("Termina: Aah~!")
    }
    
    /**
     Construct Termina with level 420.
     */
    init() {
        super.init("Termina", 420)
    }
}
