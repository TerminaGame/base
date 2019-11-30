//
//  NPC.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation
import ColorizeSwift

/**
 Non-player character class.
 
 The NPC is a docile entity that cna interact with the player and provide information. The `Player` class does have the ability to attack an NPC and kill it, though this is highly discouraged. The NPC also parses monologues and perform actions with them accordingly.
 */
class NPC: Entity {
    
    /**
     The monologue that the NPC can say.
     */
    var monologue = [""]
    
    var cheesecakeSurprise = false
    
    var quip: String
    
    /**
     Immediately kill the NPC (not recommended).
     */
    override func takeDamage(_ amount: Double) {
        health = 0
    }
    
    /**
     Say either a specific line or a random one from a list.
     
     - Parameters:
        - what: The line to say, if possible. If set to `nil`, pick randomly instead.
     */
    override func saySomething(_ what: String?) {
        if what != nil {
            super.saySomething(what ?? "Help me.")
        } else {
            super.saySomething(quip)
        }
    }
    
    /**
     Special cheesecake function!
     */
    func cheesecake() {
        if !cheesecakeSurprise {
            saySomething("Gobble gobble.")
            myPlayer.experienceUp(1)
            cheesecakeSurprise = true
        } else {
            myLogger.error("What are you doing?")
        }
    }
    
    /**
     Say the respective monologue for the NPC line by line. Pauses are distributed porportionally to the lines.
     
     Monologues can use special strings or escape sequences to manipulate how the monologue is displayed.
     
     - Adding `"PAUSE"` as an element will prompt the user to press Enter before continuing.
     - Adding `"/hold"` to the string element will cause the interpreter to pause after the line is displayed for three seconds.
     
     - Parameters:
        - instant: Whether to display all lines instantly (Bool) instead of line by line
     */
    func sayMonologue(instant: Bool) {
        parseMonologue(monologue)
        monologue = [""]
    }
    
    /**
     Construct the NPC class.
     
     - Parameters:
        - myName: Name of the NPC.
     */
    init(_ myName: String) {
        quip = Monologue().randomMonologuesNPC.randomElement() ?? "Help me."
        super.init(myName, "NPC", 100.0, TerminalColor.cyan1)
    }
}
