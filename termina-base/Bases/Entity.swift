//
//  Entity.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//
import Foundation
import ColorizeSwift

/**
 Base class for describing entities in the game.
 
 Entities are living beings in the game. They have properties of taking damage and speaking. More functions can be expanded upon in subclasses.
 */
class Entity {
    /**
     The name of the entity
     */
    var name: String
    
    /**
     The type of entity.
     */
    var type: String
    
    /**
     The entity's current health.
     */
    var health: Double
    
    /**
     The entity's full health count.
     */
    var maximumHealth: Double
    
    /**
     The entity type's color as a terminal color.
     */
    var colorType: TerminalColor
    
    /**
     Reduces the health of the entity. Sets health to 0 if a negative value is produced.
     
     - Parameters:
        - amount: The amount of damage to subract from health.
     */
    func takeDamage(_ amount: Double) {
        let tempHealth = health - amount
        if (tempHealth < 0) {
            health = 0
        } else {
            health = tempHealth
        }
    }
    
    /**
     Say a line or inputted text.
     
     - Parameters:
        - what: The line to say.
     */
    func saySomething(_ what: String) {
        print("\(name.bold().foregroundColor(colorType)): \(what)")
    }
    
    /**
     Parse a monologue given the following conditions.
     
     Monologues can use special strings or escape sequences to manipulate how the monologue is displayed.
     
     - Adding `"PAUSE"` as an element will prompt the user to press Enter before continuing.
     - Adding `"/hold"` to the string element will cause the interpreter to pause after the line is displayed for three seconds.
     
     - Parameters:
        - what: the monologue to parse.
     */
    func parseMonologue(_ what: [String]) {
        for line in what {
            if line == "PAUSE" {
                print("Press Enter to continue.".bold().lightGray())
                let _ = readLine()!
            } else {
                if (line.range(of: "/hold") != nil) {
                    let strippedLine = line.replacingOccurrences(of: "/hold", with: "")
                    print("\(name.bold().foregroundColor(colorType)): \(strippedLine)")
                    usleep(3000000)
                } else {
                    print("\(name.bold().foregroundColor(colorType)): \(line)")
                    usleep(useconds_t(50000 * line.count))
                }
            }
        }
    }
    
    /**
     Constructs the Entity class.
     
     - Parameters:
        - myName: The name of the entity.
        - myType: The entity's type.
        - myHealth: The health given to the entity.
        - myColor: The color of the entity's speech tag.
     */
    init(_ myName: String, _ myType: String, _ myHealth: Double, _ myColor: TerminalColor) {
        name = myName
        type = myType
        health = myHealth
        maximumHealth = myHealth
        colorType = myColor
    }
    
}
