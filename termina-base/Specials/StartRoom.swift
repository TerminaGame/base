//
//  StartRoom.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/31/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 The starting room of the game.
 
 The start room is a subclass of `Room` that provides a space for tutorial usage.
 */
class StartRoom: Room {
    
    /**
     The NPC to use.
     */
    var thisNPC: NPC
    
    /**
     Construct the StartRoom class.
     
     - Parameters:
        - player: The player to provide the tutorial to
        - friend: The NPC that provides the tutorial
     */
    init(_ player: Player, _ friend: NPC) {
        thisNPC = friend
        
        super.init(player, nil, command)
        super.myAttackSequence?.enemy = nil
        super.myNPC = friend
        super.myItems = []
        
    }
    
}
