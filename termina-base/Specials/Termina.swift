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
     API key for Termina.
     */
    private let apikey = "2be7654ed74eb3670ac46cf3bffd7a2c354159ab"
    
    
    /**
     Insult the player with a line of dialogue.
     */
    func insult() {
        saySomething(Monologue().terminaDerogatoryMonologue.randomElement() ?? "You're wasting my time.")
    }
    
    /**
     Speak pre-battle dialogue.
     */
    func speakBeforeFighting() {
        parseMonologue(Monologue().terminaPreBattleMonologue)
    }
    
    /**
     Damage Termina by an amount and print a painful scream.
     
     - Parameters:
        - amount: The amount of damage to give to Termina
     */
    override func takeDamage(_ amount: Double) {
        super.takeDamage(amount)
        print("\(name.bold().foregroundColor(colorType)): Aah~!")
        if health <= 0.0 {
            print("\(name.bold().foregroundColor(colorType)): No, no, no! Just die already!")
        }
    }
    
    /**
     Pacify Termina.
     
     First parses the pacify monologue and then continues the regular pacify function.
     */
    override func pacify(_ from: Player) {
        if level <= from.level || canBePacified {
            parseMonologue(Monologue().terminaPacifyMonologue)
            myLogger.info("\(name) reluctantly accepts.")
            myLogger.info("You pacified \(name) successfully!")
            from.experienceUp(7)
        } else {
            myLogger.error("\(name) can't be pacified!")
        }
        
    }
    
    /**
     Construct Termina with level 420.
     */
    init() {
        super.init("Termina", 4200)
        super.colorType = TerminalColor.orange3
        super.canBePacified = true
    }
}
