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
     */
    override func takeDamage(_ amount: Double) {
        let chance = Int.random(in: 1 ... 10)
        
        if chance <= 3 {
            myLogger.info("\(name) deflected and took no damage!")
        } else {
            super.takeDamage(amount)
        }
        
        saySomething(Monologue().randomMonologuesMonster.randomElement() ?? "Aargh!")
    }
    
    /**
     Pacify the monster and thank the player.
     */
    func pacify() {
        saySomething("R-really? Thank you so much! I didn't want to hurt you...")
    }
    
    /**
     Constructs the Monster class. Sets type to Monster with health 50 automatically. Attack is defined by inputted level.
     
     - Parameters:
        - monsterName: The name of the monster.
        - myLevel: The monster's level.
     */
    init(_ monsterName: String, _ myLevel: Int) {
        super.init(monsterName, "Monster", 100, TerminalColor.red)
        level = myLevel
        attack = Double(myLevel)
    }
}
