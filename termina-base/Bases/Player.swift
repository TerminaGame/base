//
//  Player.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//
import Foundation

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
     Reduces the health of the entity. Sets health to 0 if a negative value is produced.
     
     - Parameters:
     - amount: The amount of damage to subract from health.
     */
    override func takeDamage(_ amount: Double) {
        let tempHealth = health - amount
        if (tempHealth <= 0) {
            health = 0
            myLogger.info("You died!")
            myLogger.info("The game is now over. Exiting to terminal...")
            myLogger.askForLogBeforeExiting()
            exit(2)
        } else {
            health = tempHealth
        }
    }
    
    
    /**
     Heals the player by an amount. If resultant health is over maximum, sets it to maximum instead.
     Will also increase XP by 5 points.
     
     - Parameters:
        - amount: The amount to heal by.
     
     - Returns: Boolean value if the heal operation didn't go over the maximum health
     */
    func heal(_ amount: Double) -> Bool {
        let temporaryHealth = health + amount
        if temporaryHealth > maximumHealth {
            myLogger.warning("You cannot heal higher than your maximum health!")
            health = maximumHealth
            return false
        } else {
            health = temporaryHealth
            experienceUp(3)
            return true
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
        myLogger.info("You upgraded to v.\(String(level ?? 1).cyan())!".bold())
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
        
        myLogger.info("You're patched to v.\(level ?? 1).\(experience ?? 0)!")
    }
    
    /**
     Lists information about the Player.
     */
    func listProperties() {
        let myLevel = String(level)
        let myExperience = String(experience)
        let patch = String(25 - experience)
        print("=== \(name.bold()) v.\(myLevel).\(myExperience.cyan()) ===".foregroundColor(TerminalColor.orange3))
        print("Patches until next version: \(patch)".cyan())
        if health <= 10.0 {
            print("Health: \(String(health).red().blink().bold())/\(maximumHealth)".yellow())
        } else {
            print("Health: \(health)/\(maximumHealth)".yellow())
        }
        
        print("Current Inventory: ")
        
        if inventory.isEmpty != true {
            for item in inventory {
                if item is Weapon {
                    let weaponTemp = item as? Weapon
                    print(" - \(weaponTemp?.name ?? "NSWeapon") v.\(weaponTemp?.level ?? 1) (\(((weaponTemp?.currentUse ?? 1))) uses left)")
                } else {
                    print(" - \(item.name) (\(item.currentUse) uses left)")
                }
            }
        } else {
            print(" - Inventory empty!")
        }
        print("\n")
    }
    
    /**
     Constructs the Player class. Automatically initializes the Entity class with type Player health and health at 100.
     
     - Parameters:
        - myName: The name of the player.
     */
    init(_ myName: String) {
        super.init(myName, "Player", 100, TerminalColor.grey)
        experience = 0
        level = 1
    }
}
