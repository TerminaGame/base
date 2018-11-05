//
//  Entity.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

/**
 Base class for describing entities in the game.
 
 Entities are living beings in the game. They have properties of taking damage and can be expanded upon in subclasses.
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
     Say a random line picked from a list of dialogues.
     
     This is usually aready dertermined through its construction and is stored in `quip`.
     */
    func saySomething(_ what: String) {
        print("\(name.bold().foregroundColor(colorType)): \(what)")
    }
    
    /**
     Constructs the Entity class.
     
     - Parameters:
        - myName: The name of the entity.
        - myType: The entity's type.
        - myHealth: The health given to the entity.
     */
    init(_ myName: String, _ myType: String, _ myHealth: Double, _ myColor: TerminalColor) {
        name = myName
        type = myType
        health = myHealth
        maximumHealth = myHealth
        colorType = myColor
    }
    
}
