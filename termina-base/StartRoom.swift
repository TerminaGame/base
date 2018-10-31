//
//  StartRoom.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/31/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

class StartRoom: Room {
    
    var thisNPC: NPC
    
    init(_ player: Player, _ friend: NPC) {
        thisNPC = friend
        
        super.init(player, nil, command)
        super.myAttackSequence?.enemy = nil
        super.myNPC = friend
        super.myItems = []
        
    }
    
}
