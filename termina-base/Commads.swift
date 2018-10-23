//
//  Commads.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

class CommandInterpreter {
    
    /**
     Interpret the given input to perform an action.
     
     - Parameters:
        - command: The command to try running
        - room: The room the player is located in.
     */
    func parseCommand(_ command: String, _ room: Room, _ settingsHandler: SettingsManager) {
        switch command {
        case "attack":
            if room.monsterHere {
                room.attackHere()
            } else {
                print("You cannot attack now, there is no monster nearby.")
            }
            break
        case "heal":
            for obj in room.myItems {
                if obj is Potion {
                    obj.use()
                    break
                } else if !(obj is Potion) {
                    print("You can't use \(obj.name) to heal yourself.")
                    room.myItems.removeFirst()
                } else {
                    print("There's nothing here, silly.")
                }
                break
            }
        case "exit":
            print("Are you sure you want to exit? (y/n)\nNote: Your player status will be saved, but your inventory or room data will NOT.")
            
            if (readLine()! == "y") || (readLine()! == "yes") {
                settingsHandler.saveSettings()
                exit(0)
            } else if (readLine()! == "n") || (readLine()! == "no") {
                break
            }
        case "aboutself":
            let myLevel = String(myPlayer.level)
            let myExperience = String(myPlayer.experience)
            print("===\(myPlayer.name)===")
            print("Level: [\(myLevel)]")
            print("Progress to next Level: [\(myExperience)]")
            print("Health: \(myPlayer.health)/\(myPlayer.maximumHealth)")
            break
        case "aboutroom":
            print("===Current Room===")
            if room.monsterHere {
                let monsterLevel = String(room.myMonster!.level)
                print("[!] A monster is present!")
                print("Monster Level: [\(monsterLevel)]")
            } else {
                print("No threats detected.")
            }
            print("Items: ")
            
            for obj in room.myItems {
                if obj is Weapon {
                    let thisWeapon = obj as! Weapon
                    let weaponLevel = String(thisWeapon.level!)
                    print(" - \(thisWeapon.name) [Level \(weaponLevel)]")
                } else {
                    print(" - \(obj.name)")
                }
            }
            break
        case "leave":
            if room.monsterHere == false {
                room.isDestroyed = true
            } else {
                print("[E] You cannot leave now, there are monsters nearby.")
            }
            break
        case "equip":
            for obj in room.myItems {
                if obj is Weapon {
                    let useWeapon = obj as! Weapon
                    useWeapon.equip()
                    room.myItems.removeLast()
                }
            }
            break
        
        case "save":
            settingsHandler.saveSettings()
            print("[I] Player data saved!")
            break
        
        case "help":
            print("""
===List of Commands===
aboutroom - displays information about the room.
aboutself - displays information about oneself.
attack - attacks the monster in the room, if present.
equip - Equip the weapon in the room, if possible.
exit - quits the game.
help - displays this screen.
heal - heals your health.
save - saves your player profile.
leave - leave the room, if possible.
""")
            break
        default:
            print("\(command) is not a valid command. Type 'help' to see a list of commands.")
            break
        }
    }
}
