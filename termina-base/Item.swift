//
//  Item.swift
//  Termina
//
//  Created by Marquis Kurt on 10/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

class Item {
    var name, type: String
    var effect: Int
    var maximumUse, currentUse: Int
    
    /**
     Use the item and decrement the amount of uses.
     */
    func use() {
        if (currentUse < 0 ) {
            print("[E] Item can no longer be used.")
        } else {
            currentUse = currentUse - 1
            print("[W] This item now has \(currentUse + 1) uses left!")
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
        maximumUse = Int.random(in: 1 ... 10)
        currentUse = maximumUse
    }
}
