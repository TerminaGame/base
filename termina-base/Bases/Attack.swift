//
//  Attack.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Class for designing attack scenes between the player and a monster.
 */
class AttackScene {
    
    var player: Player?
    var enemy: Monster?
    
    /**
     Allow each entity to attack each other.
     
     The process for attacking usually starts with the player attacking the monster first. This attack number is given by the player's level added with their temporary level (given by a weapon).
     
     - If ther player does _not_ have a weapon, their temporary level is set between 1 and 5 randomly each time.
     
     The enemy may have the ability to deflect and ignore damage on a random basis. If the level is set to 0 or below immediately, the enemy is destroyed and the player cna leave. Otherwise, the enemy takes the chance to attack based on its level.
     */
    func attack() {
        for item in (player?.inventory)! {
            if item is Weapon {
                item.use()
            }
        }
        let damageFromPlayer = Double(((player?.level! ?? 1)) + (player?.temporaryLevel ?? Int.random(in: 1 ... 5)))
        enemy?.takeDamage(damageFromPlayer)
        if (enemy?.health == 0) {
            myLogger.info("\(enemy?.name ?? "The enemy") is now caught!")
            enemy = nil
            player?.experienceUp(5)
        } else {
            let enemyHealth = String(enemy!.health)
            myLogger.info("\(enemy?.name ?? "Monster") is injured! Its health is \(enemyHealth).")
            enemy?.attackPlayer(player!)
            let selfHealth = String(player!.health)
            
            if (player?.health == 0) {
                player = nil
                myLogger.info("You died! \(enemy?.name ?? "Monster") has killed you.")
                myLogger.info("The game is now over. Exiting to terminal...")                
                myLogger.askForLogBeforeExiting()
                exit(1)
            }
            myLogger.warning("\(enemy?.name ?? "Monster") injured you! Your health is \(selfHealth).")
        }
    }
    
    /**
     Construct the AttackScene object.
     
     - Parameters:
        - whichPlayer: the player involved in the attack scene.
        - whichMonster: the monster involved in the attack scene.
     */
    init(_ whichPlayer: Player, _ whichMonster: Monster) {
        player = whichPlayer
        enemy = whichMonster
    }
}
