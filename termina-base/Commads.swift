//
//  Commads.swift
//  Termina
//
//  Created by Marquis Kurt on 10/17/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Interpreter for given commands, either by user input in a terminal or from a button assignment.
 */
class CommandInterpreter {
    
    /**
     Interpret the given input to perform an action.
     
     - Parameters:
        - command: The command to try running
        - room: The room the player is located in.
        - settingsHandler: The settings manager to save and load player data.
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
                        if obj.currentUse == 0 {
                            room.myItems.removeFirst()
                        }
                        break
                    } else if !(obj is Potion) {
                        print("You can't use \(obj.name) to heal yourself.")
                    } else {
                        print("There's nothing here, silly.")
                    }
                    break
                }
            
            case "xp":
                for obj in room.myItems {
                    if obj is Bottle {
                        obj.use()
                        room.myItems.removeFirst()
                    } else if !(obj is Bottle) {
                        print("You cannot upgrade your XP with a \(obj.name).")
                    } else {
                        print("There's nothing here, silly.")
                    }
                }
                break
            
            case "exit":
                print("Are you sure you want to exit? (y/n)")
                
                if (readLine()! == "y") || (readLine()! == "yes") {
                    settingsHandler.saveSettings()
                    exit(0)
                } else if (readLine()! == "n") || (readLine()! == "no") {
                    break
                }
            
            case "aboutself":
                let myLevel = String(myPlayer.level)
                let myExperience = String(myPlayer.experience)
                print("=== \(myPlayer.name) ===")
                print("Level \(myLevel)")
                print("Progress to next Level: \(myExperience)/25")
                print("Health: \(myPlayer.health)/\(myPlayer.maximumHealth)")
                print("Current Inventory: ")
                
                if myPlayer.inventory.isEmpty != true {
                    for item in myPlayer.inventory {
                        if item is Weapon {
                            let weaponTemp = item as? Weapon
                            print(" - \(weaponTemp?.name ?? "Weapon") [Level \(weaponTemp?.level ?? 0)] (\((weaponTemp?.currentUse ?? 0) + 1 ) uses left)")
                        } else {
                            print(" - \(item.name) (\(item.currentUse) uses left)")
                        }
                    }
                } else {
                    print(" - Inventory empty!")
                }
                break
            
            case "aboutroom":
                print("=== Current Room ===")
                if room.monsterHere {
                    let monsterLevel = String(room.myMonster!.level)
                    let monsterName = room.myMonster?.name
                    print("\(monsterName ?? "Monster") [Level \(monsterLevel)]")
                } else {
                    print("No threats detected.")
                }
                
                if room.myItems.isEmpty != true {
                    print("Items: ")
                    for obj in room.myItems {
                        if obj is Weapon {
                            let thisWeapon = obj as! Weapon
                            let weaponLevel = String(thisWeapon.level!)
                            print(" - \(thisWeapon.name) [Level \(weaponLevel)]")
                        } else {
                            print(" - \(obj.name) (\(obj.currentUse) uses left)")
                        }
                    }
                } else {
                    print("There are no items here.")
                }
                break
            
            case "leave":
                if room.monsterHere == false {
                    room.isDestroyed = true
                } else {
                    print("[E] You cannot leave now, there are monsters nearby.\nHave you deleted them?")
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
            
            case "clear":
                print("\u{001B}[2J")
                break
            
            case "help":
                print("""
    === List of Commands ===
    == Getting Information ==
    aboutroom - displays information about the room.
    aboutself - displays information about oneself.

    == Interactions ==
    attack - attacks the monster in the room, if present.
    equip - Equip the weapon in the room, if possible.
    heal - restores your health by an amount.
    xp - use an experience-enhancing bottle, if possible.
    
    == Miscellaneous ==
    clear - clears the console screen.
    exit - quits the game.
    help - displays this screen.
    leave - leave the room, if possible.
    save - saves your player profile.
    """)
                break
            default:
                print("\(command) is not a valid command. Type 'help' to see a list of commands.")
                break
        }
    }
}
