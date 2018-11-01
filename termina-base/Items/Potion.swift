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
            player.heal(Double(effect))
            super.use()
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
