//
//  NPC.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Non-player character class.
 */
class NPC: Entity {
    
    let monologue = [""]
    
    /**
     Immediately kill the NPC (not recommended).
     */
    override func takeDamage(_ amount: Double) {
        health = 0
    }
    
    /**
     Say the respective monologue for the NPC line by line.
     
     - Parameters:
        - instant: Whether to display all lines instantly (Bool) instead of line by line
     */
    func sayMonologue(instant: Bool) {
        for line in monologue {
            print("\(name): \(line)")
            if !instant {
                sleep(2)
            }
        }
    }
    
    /**
     Construct the NPC class.
     
     - Parameters:
        - myName: Name of the NPC.
     */
    init(_ myName: String) {
        super.init(myName, "NPC", 100.0)
    }
}
