//
//  Bottle.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Item to increase player's experience by an amount. Instant one-time use.
 */
class Bottle: Item {
    
    var player: Player!
    
    /**
     Add the experience points and then break immediately.
     */
    override func use() {
        player.experienceUp(effect)
        super.use()
    }
    
    /**
     Construct the Bottle class.
     
     - Parameters:
        - myName: the name of the bottle.
        - affectedPlayer: the player to receive the experience upgrade.
     */
    init(_ myName: String, _ affectedPlayer: Player) {
        super.init(myName, "Bottle")
        maximumUse = 1
        currentUse = 1
        player = affectedPlayer
    }
    
}
