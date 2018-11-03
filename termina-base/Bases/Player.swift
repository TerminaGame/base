//
//  Player.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

/**
 Primary entity to interact with items and attack monsters. Takes and stores data from `settings.json`
 
 The `Player` class is the user's primary means of interacting with things in the game. This class store properties about the player and progress made in the game.
 */
class Player: Entity {
    /**
     The player's experience.
     
     The experience value is a means of providing progression in the game without always upgrading the level.
     */
    var experience: Int!
    
    /**
     The player's level.
     
     This level must reach 420 or higher to fight Termina and win the game.
     */
    var level: Int!
    
    /**
     Temporary holding space to increase level.
     
     This area is often used by items to increase the player's attack levels.
     */
    var temporaryLevel: Int!
    
    /**
     An array of items that the player is carrying on them.
     */
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
        experienceUp(3)
    }
    
    /**
     Levels the player up and resets the experience points to 0.
     
     - Parameters:
        - amount: The amount to level up by.
     */
    func levelUp(_ amount: Int) {
        level += amount
        experience = 0
        myLogger.info("You leveled up to level \(level ?? 1)!")
    }
    
    /**
     Adds experience to the player. If the result is over the maximum (25), level up to the next level and add the leftover experience.
     
     - Parameters:
        - amount: The amount of experience to add to the player.
     */
    func experienceUp(_ amount: Int) {
        let temporaryExperience = experience + amount
        
        if temporaryExperience >= 25 {
            let storedExperienceFromOverflow = temporaryExperience - 25
                levelUp(1)
                experience = storedExperienceFromOverflow
        } else {
            experience = temporaryExperience
        }
        
        myLogger.info("Your experience is now \(experience ?? 0)!")
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
