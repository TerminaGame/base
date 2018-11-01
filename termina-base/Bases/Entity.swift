//
//  Entity.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

/**
 Base class for describing entities in the game.
 */
class Entity {
    var name, type: String
    var health, maximumHealth: Double
    
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
     Constructs the Entity class.
     
     - Parameters:
        - myName: The name of the entity.
        - myType: The entity's type.
        - myHealth: The health given to the entity.
     */
    init(_ myName: String, _ myType: String, _ myHealth: Double) {
        name = myName
        type = myType
        health = myHealth
        maximumHealth = myHealth
    }
    
}
