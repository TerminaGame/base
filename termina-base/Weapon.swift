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
    func equip() {
        
        for object in equipper.inventory {
            if object is Weapon {
                let weapon = object as? Weapon
                print("[W] You already have a weapon equipped, \(weapon?.name ?? "Weapon"). Are you sure you want to equip \(name) instead? (y/n)")
                
                let response = readLine()!
                if (response == "yes" || response == "y") {
                    weapon?.unequip()
                } else {
                    print("[E] Operation aborted.")
                    break
                }
            }
        }
        
        equipper.inventory.append(self)
        equipper.levelUp(level)
    }
    /**
     Unequip the weapon.
     */
    func unequip() {
        // equipper.level = equipper.level - level
        if currentUse == maximumUse {
            equipper.level = equipper.level - level
        }
        
        equipper.inventory.removeFirst()
    }
    
    /**
     Use the weapon and decrease its use value, including the player's level.
     */
    override func use() {
        if (currentUse <= 0) {
            print("[E] Your weapon can no longer be used!")
            unequip()
        } else {
            super.use()
            if (equipper.level - 1 < 0) {
                equipper.level = 1
            } else {
                equipper.level = equipper.level - 1
            }
        }
    }
    
    init(_ itemName: String, _ equipLevel: Int, _ equippedPlayer: Player) {
        super.init(itemName, "Weapon")
        level = equipLevel
        equipper = equippedPlayer
    }
}
