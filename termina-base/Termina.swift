//
//  Termina.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Main Termina villain. Subclass of `Monster` class.
 */
class Termina: Monster {
    
    var speaker = Monologue()
    
    /**
     Insult the player with a line of dialogue.
     */
    func insult() {
        print(speaker.terminaDerogatoryMonologue.randomElement() ?? "You're wasting my time.")
    }
    
    /**
     Construct Termina with level 420.
     */
    init() {
        super.init("Termina", 420)
    }
}
