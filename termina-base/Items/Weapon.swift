//
//  Weapon.swift
//  Termina
//
//  Created by Marquis Kurt on 10/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Item to increase player's level and allow attacking monsters with higher damage.
 
 The `Weapon` is a means of providing additional damage to a `Monster` class via an `AttackScene`. Weapons can only be used during attacks with Monsters and have no effect in damaging NPCs.
 */
class Weapon: Item {
    
    var level: Int!
    var equipper: Player!
    
    /**
     Equip the weapon and level up the player temporarily.
     
     Will automatically check if an item is equipped and prompt the user to switch weapons.
     */
    func equip() -> Bool {
        
        var abortOperation = false
        
        for object in equipper.inventory {
            if object is Weapon {
                let weapon = object as? Weapon
                
                let swapWeaponPrompt = myLogger.ask("You have \(weapon?.name ?? "a weapon") v.\(weapon?.level ?? 0) already equipped. Are you sure you want to equip \(name) v.\(level ?? 0) instead?")
                
                if swapWeaponPrompt {
                    weapon?.unequip()
                } else {
                    myLogger.error("Operation aborted.")
                    abortOperation = true
                    return false
                }
            }
        }
        
        if !abortOperation {
            equipper.inventory.append(self)
            equipper.temporaryLevel = level
            myLogger.info("\(name) has been equipped! Your attack score is \(level + equipper.level).")
            return true
        }
        
    }
    /**
     Unequip the weapon.
     */
    func unequip() {
        if currentUse == maximumUse {
            equipper.temporaryLevel = 0
        }
        
        equipper.inventory.removeFirst()
    }
    
    /**
     Use the weapon and decrease its use value, including the player's level.
     */
    override func use() {
        if (currentUse <= 0) {
            myLogger.error("Your weapon can no longer be used!")
            unequip()
        } else {
            super.use()
            if (equipper.temporaryLevel - 1 < 0) {
                equipper.temporaryLevel = 0
                myLogger.error("Your weapon can no longer be used!")
                unequip()
            } else {
                equipper.temporaryLevel = equipper.temporaryLevel - 1
            }
        }
    }
    
    
    /**
     Construct the Weapon class.
     
     - Parameters:
        - itemName: The name of the weapon.
        - equipLevel: The level of the weapon.
        - equippedPlayer: The player that uses the weapon.
     */
    init(_ itemName: String, _ equipLevel: Int, _ equippedPlayer: Player) {
        super.init(itemName, "Weapon")
        level = equipLevel
        equipper = equippedPlayer
    }
}
