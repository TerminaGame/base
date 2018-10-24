//
//  Room.swift
//  Termina
//
//  Created by Marquis Kurt on 10/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Base element that can contain items and a monster, as well as its name generators and attack scenes.
 */
class Room {
    var myMonster: Monster?
    var monsterHere = false
    var myAttackSequence: AttackScene?
    var myItems = [Item]()
    var isDestroyed = false
    let myNameGen = NameGenerator()
    
    /**
     Attempt to attack the monster in the room. If the monster is dead from attack, removes it from Room.
     */
    func attackHere() {
        if myAttackSequence?.enemy != nil {
            myAttackSequence?.attack()
        } else {
            monsterHere = false
            myMonster = nil
        }
    }
    
    /**
     Constructs the Room object. Randomly adds monsters and an attack sequence if necessary.
     
     - Parameters:
        - player: The player to put into the room
     */
    init(_ player: Player) {
        let chance = Int.random(in: 0 ... 9)
        
        if (chance > 4) {
            myMonster = Monster(myNameGen.generateMonsterName(), Int.random(in: player.level ... player.level + 2))
            monsterHere = true
            myAttackSequence = AttackScene(player, myMonster!)
        }
        
        if (chance >= 4) {
            let myPotion = Potion("Heal Potion", player)
            myItems.append(myPotion)
        }
        
        if (chance >= 3 && chance <= 6) {
            let myWeapon = Weapon(myNameGen.generateWeaponName(), chance, player)
            myItems.append(myWeapon)
        }
    }
    
}
