//
//  Potion.swift
//  Termina
//
//  Created by Marquis Kurt on 10/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Item to restore player's health
 
 The `Potion` is a temporary item locked to a room that heals the player by random amount. The `effect` uses the standard `Item` effect.
 */
class Potion: Item {
    
    var player: Player!
    
    /**
     Use the potion to heal the player and decrement its use value.
     */
    override func use() {
        if (currentUse <= 0) {
            myLogger.error("The potion can no longer heal you.")
        } else {
            super.use()
            let didPlayerOverflowDuringHealing = player.heal(Double(effect))
            if !didPlayerOverflowDuringHealing {
                myLogger.info("Health has been restored to \(player.health)!")
            } else if player.health == player.maximumHealth && !didPlayerOverflowDuringHealing {
                myLogger.info("Health has been fully restored!")
            }
            
        }
    }
    
    /**
     Construct the Potion object.
     
     - Parameters:
        - itemName: The name of the potion.
        - affectedPlayer: The player to apply the potion to.
     */
    init(_ itemName: String, _ affectedPlayer: Player) {
        player = affectedPlayer
        super.init(itemName, "Potion")
    }
    
}
