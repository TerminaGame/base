//
//  Player.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

/**
 Primary entity to interact with items and attack monsters. Takes and stores data from `settings.json`
 */
class Player: Entity {
    var experience, level: Int!
    var temporaryLevel: Int!
    var inventory = [Item]()
    
    /**
     Heals the player by an amount. If resultant health is over maximum, sets it to maximum instead.
     Will also increase XP by 5 points.
     
     - Parameters:
        - amount: The amount to heal by.
     */
    func heal(_ amount: Double) {
        health += amount

        if (health > maximumHealth) {
            health = maximumHealth
        }
        experience += 3
        if (experience >= 25) {
            levelUp(1)
        }
    }
    
    /**
     Levels the player up and resets the experience points to 0.
     
     - Parameters:
        - amount: The amount to level up by.
     */
    func levelUp(_ amount: Int) {
        level += amount
        experience = 0
    }
    
    /**
     Constructs the Player class. Automatically initializes the Entity class with type Player health and health at 100.
     
     - Parameters:
        - myName: The name of the player.
     */
    init(_ myName: String) {
        super.init(myName, "Player", 100)
        experience = 0
        level = 1
    }
}
