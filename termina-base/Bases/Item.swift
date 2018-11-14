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
 
 Items are primary means of manipulating the game. Items can be used and its subclasses can add additional methods to do multiple functions such as healing players and attacking monsters.
 */
class Item {
    /**
     The name of the item.
     */
    var name: String
    
    /**
     The type of item.
     
     Other classes can use this as a means of determining the item's type for further use.
     */
    var type: String
    
    /**
     Item effect.
     
     The effect is ameans of stating the item's power in any context.
     */
    var effect: Int
    
    /**
     The maximum amount of uses for the item.
     */
    var maximumUse: Int
    
    /**
     The amount of uses for this item.
     */
    var currentUse: Int
    
    
    /**
     Use the item and decrement the amount of uses.
     */
    func use() {
        if (currentUse <= 0 ) {
            myLogger.error("\(name) can no longer be used.")
        } else {
            if currentUse - 1 <= 0 {
                currentUse = 0
                myLogger.error("\(name) is broken and can no longer be used.")
            } else {
                currentUse = currentUse - 1
                myLogger.warning("\(name) now has \(currentUse) uses left!")
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
