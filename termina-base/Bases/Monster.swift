//
//  Monster.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//
import Foundation

/**
 Primary enemy that attacks players.
 
 Monsters are primary enemies. Monsters will never be directly used but are placed in an attack sequence.
 */
class Monster: Entity {
    /**
     The monster's level.
     */
    var level: Int!
    
    /**
     The monster's power in attack.
     
     This value is usually set to match the level. The higher this value is, the more damage it gives to an entity.
     */
    var attack: Double!
    
    /**
     The line used when pacified.
     */
    var pacifyQuip: String
    
    /**
     Override variable for pacifying.
     
     This can be used in the event that the monster's level is much higher than the player but should be pacified.
     */
    var canBePacified = false
    
    /**
     Attack a player by the attack amount.
     
     - Parameters:
        - who: The Player object to inflict damage upon.
     */
    func attackPlayer(_ who: Player) {
        who.takeDamage(attack)
    }
    
    /**
     Takes damage by an amount. May randomly deflect.
     
     - Parameters:
        - amount: The amount to take damage, if possible.
     
     - Returns: Boolean value if taking damage was successful.
     */
    func takeDamageOrDeflect(_ amount: Double) -> Bool {
        let chance = Int.random(in: 1 ... 10)
        
        if chance <= 3 {
            myLogger.info("\(name) deflected and took no damage!")
            return false
        } else {
            super.takeDamage(amount)
        }
                
        if Int.random(in: 1 ... 50) > 23 {
            saySomething(Monologue().randomMonologuesMonster.randomElement() ?? "Aargh!")
        }
        return true
    }
    
    /**
     Pacify the monster and thank the player.
     */
    func pacify(_ from: Player) {
        if level <= from.level || canBePacified {
            myLogger.info("\(name) accepts.")
            myLogger.logToFile("[-]>[-]<>++++++++[<++++++++>-]<++++.>+++++++[<+++++++>-]<------.>+++++++++[<--------->-]<++.>+++++++++[<+++++++++>-]<++++++++.>+++[<--->-]<-.>++[<++>-]<++.>+++++++++[<--------->-]<----.>+++++++++[<+++++++++>-]<+++.>+++[<--->-]<---.+.>++[<++>-]<+.---.>+++++++++[<--------->-]<++++++.>+++++++++[<+++++++++>-]<++++++++.>+++[<--->-]<-.>++[<++>-]<++.>+++++++++[<--------->-]<----.>++++++++[<++++++++>-]<+++.--.>++++[<++++>-]<---.>+++++++++[<--------->-]<+++.>+++++++++[<+++++++++>-]<++++++.>++++[<---->-]<++.>++[<++>-]<+.>+++++++++[<--------->-]<+++.>++++++++[<++++++++>-]<++.>+++++[<+++++>-]<--.>+++++++++[<--------->-]<--------.>++++++++[<++++++++>-]<++.+++.+.>+++[<+++>-]<+++.>+++[<--->-]<.----.>+++[<+++>-]<.>+++[<--->-]<-.>++[<++>-]<+.>++[<++>-]<+.>+++[<--->-]<++.>++++++++[<-------->-]<-------.>+++++++++[<+++++++++>-]<++++++++.>+++[<--->-]<-.>++[<++>-]<++.---.>+++++++++[<--------->-]<-.>+++++++++[<+++++++++>-]<--.>+++[<+++>-]<-.>+++[<--->-]<.>+++++++++[<--------->-]<+++.>++++++++[<++++++++>-]<++++++.>+++[<+++>-]<.>+++[<--->-]<-.>++++++[<------>-]<--.", "error")
            saySomething(pacifyQuip)
            myLogger.info("You pacified \(name) successfully!")
            from.experienceUp(7)
        } else {
            myLogger.error("\(name) can't be pacified!")
        }
        
    }
    
    /**
     Constructs the Monster class. Sets type to Monster with health 50 automatically. Attack is defined by inputted level.
     
     - Parameters:
        - monsterName: The name of the monster.
        - myLevel: The monster's level.
     */
    init(_ monsterName: String, _ myLevel: Int) {
        pacifyQuip = Monologue().pacifyMonologues.randomElement() ?? "Uwu"
        super.init(monsterName, "Monster", 100, TerminalColor.red)
        level = myLevel
        attack = Double(myLevel) + 5.0
    }
}
