//
//  Weapon.swift
//  Termina
//
//  Created by Marquis Kurt on 10/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

class Weapon: Item {
    
    var level: Int!
    var equipper: Player!
    
    /**
     Equip the weapon and level up the player temporarily.
     */
    func equip() {
        
        for object in equipper.inventory {
            if object is Weapon {
                equipper.inventory.removeFirst()
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
            equipper.level = equipper.level - 1
        }
    }
    
    init(_ itemName: String, _ equipLevel: Int, _ equippedPlayer: Player) {
        super.init(itemName, "Weapon")
        level = equipLevel
        equipper = equippedPlayer
    }
}
