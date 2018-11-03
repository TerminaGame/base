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
 */
class Weapon: Item {
    
    var level: Int!
    var equipper: Player!
    
    /**
     Equip the weapon and level up the player temporarily.
     */
    func equip() -> Bool {
        
        var abortOperation = false
        
        for object in equipper.inventory {
            if object is Weapon {
                let weapon = object as? Weapon
                
                let swapWeaponPrompt = myLogger.ask("You have \(weapon?.name ?? "a weapon") already equipped. Are you sure you want to equip \(name) instead?")
                
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
            } else {
                equipper.temporaryLevel = equipper.temporaryLevel - 1
            }
        }
    }
    
    init(_ itemName: String, _ equipLevel: Int, _ equippedPlayer: Player) {
        super.init(itemName, "Weapon")
        level = equipLevel
        equipper = equippedPlayer
    }
}
