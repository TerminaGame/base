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
     */
    func attack() {
        for item in (player?.inventory)! {
            if item is Weapon {
                item.use()
            }
        }
        let damageFromPlayer = Double(((player?.level ?? 1)) + (player?.temporaryLevel ?? 0))
        let totalDamageFromPlayer = damageFromPlayer * 1.5
        enemy?.takeDamage(totalDamageFromPlayer)
        if (enemy?.health == 0) {
            Logger().info("\(enemy?.name ?? "The enemy") is now stunned. Attack one more time to kill it permanently.")
            enemy = nil
            player?.experienceUp(5)
        } else {
            let enemyHealth = String(enemy!.health)
            Logger().info("\(enemy?.name ?? "Monster") is injured! Its health is \(enemyHealth).")
            enemy?.attackPlayer(player!)
            let selfHealth = String(player!.health)
            
            if (player?.health == 0) {
                player = nil
                Logger().info("You died! \(enemy?.name ?? "Monster") has killed you.")
                Logger().info("The game is now over. Exiting to terminal...")
                exit(1)
            }
            Logger().warning("\(enemy?.name ?? "Monster") injured you! Your health is \(selfHealth).")
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
