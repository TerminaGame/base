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
 */
class Monster: Entity {
    
    var level: Int!
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
        let chance = Double(round(10*Double.random(in: 0.0 ... 9.0))/10)
        //let chance = Double.random(in: 0.0 ... 9.0).rounded(FloatingPointRoundingRule.awayFromZero)
        super.takeDamage(chance)
    }
    
    /**
     Constructs the Monster class. Sets type to Monster with health 50 automatically. Attack is defined by inputted level.
     
     - Parameters:
        - monsterName: The name of the monster.
        - myLevel: The monster's level.
     */
    init(_ monsterName: String, _ myLevel: Int) {
        super.init(monsterName, "Monster", 50)
        level = myLevel
        attack = Double(myLevel) * 1.5
    }
}
