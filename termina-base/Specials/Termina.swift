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
     Heals Termina by an amount. If resultant health is over maximum, sets it to maximum instead.
     
     - Parameters:
        - amount: The amount to heal by.
     
     - Returns: Boolean value if the heal operation didn't go over the maximum health
     */
    func heal(_ amount: Double) -> Bool {
        let temporaryHealth = health + amount
        if temporaryHealth > maximumHealth {
            health = maximumHealth
            return false
        } else {
            health = temporaryHealth
            return true
        }
    }
    
    /**
     Damage Termina by an amount and print a painful scream.
     
     - Parameters:
        - amount: The amount of damage to give to Termina
     */
    override func takeDamageOrDeflect(_ amount: Double) -> Bool {
        let chance = Int.random(in: 1 ... 10)
        
        if chance <= 5 {
            myLogger.info("\(name) deflected and took no damage!")
            return false
        } else {
            super.takeDamage(amount)
        }
        
        print("\(name.bold().foregroundColor(colorType)): Aah~!")
        
        if health >= maximumHealth / 2 {
            let _ = heal(Double(Int.random(in: 5 ... 7)))
            myLogger.warning("Termina used a script and healed herself! Her health is \(health).")
        } else if health <= 0.0 {
            print("\(name.bold().foregroundColor(colorType)): No, no, no! Just die already!")
        }
        return true
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
        super.init("Termina", 420)
        super.maximumHealth = 9001
        super.health = 9001
        super.attack = 10
        super.colorType = TerminalColor.orange3
        super.canBePacified = true
    }
}
