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
     Provides and instance of the Monologue class.
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
     */
    func speakBeforeFighting() {
        for line in speaker.terminaPreBattleMonologue {
            print("Termina: \(line)")
            sleep(2)
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
