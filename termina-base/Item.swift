//
//  Item.swift
//  Termina
//
//  Created by Marquis Kurt on 10/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Base class for describing items in the game.
 */
class Item {
    var name, type: String
    var effect: Int
    var maximumUse, currentUse: Int
    
    /**
     Use the item and decrement the amount of uses.
     */
    func use() {
        if (currentUse < 0 ) {
            Logger().error("\(name) can no longer be used.")
        } else {
            currentUse = currentUse - 1
            
            if currentUse == 0 {
                Logger().warning("\(name) is broken and can no longer be used.")
            } else {
                Logger().warning("\(name) now has \(currentUse) uses left!")
            }
        }
    }
    
    /**
     Constructs the Item object. Its effect level and amount of uses is assigned randomly from 1 to 10.
     
     - Parameters:
        - itemName: The name of the item.
        - itemType: The type of item.
     */
    init(_ itemName: String, _ itemType: String) {
        name = itemName
        type = itemType
        effect = Int.random(in: 10 ... 20)
        maximumUse = Int.random(in: 2 ... 10)
        currentUse = maximumUse
    }
}
