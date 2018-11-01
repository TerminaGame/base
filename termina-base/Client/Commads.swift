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
            
        /*
            GETTING INFORMATION
        */
            
        case "aboutroom":
            print("=== \("Current Room".bold()) ===".foregroundColor(TerminalColor.orange3))
            if room.myAttackSequence?.enemy != nil {
                let monsterLevel = String(room.myMonster!.level)
                let monsterName = room.myMonster?.name
                print("\(monsterName ?? "Monster") [Level \(monsterLevel)] (Enemy)".red())
                
                if myPlayer.level <= 3 {
                    print("Use the \("attack".bold()) command to catch the error!".green())
                }
                
            } else if room.myNPC != nil {
                print("\(room.myNPC?.name ?? "NPC") (NPC)")
                
                if myPlayer.level <= 3 {
                    print("Use the \("talk".bold()) command to interact!".green())
                }
                
            } else {
                print("There are no entities here.")
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
            print("\n")
            break
        case "aboutself":
            let myLevel = String(myPlayer.level)
            let myExperience = String(myPlayer.experience)
            print("=== \(myPlayer.name.bold()) ===".foregroundColor(TerminalColor.orange3))
            print("Level \(myLevel)")
            print("Progress to next Level: \(myExperience)/25".cyan())
            print("Health: \(myPlayer.health)/\(myPlayer.maximumHealth)".yellow())
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
            print("\n")
            break
            
        
            
        /*
            INTERACTIONS
         */
        case "attack":
            if room.myAttackSequence?.enemy != nil {
                room.attackHere()
            } else if room.myNPC != nil {
                room.myNPC?.takeDamage(1)
                myLogger.error("You killed \((room.myNPC?.name ?? "NPC").bold())! You monster...")
                room.myNPC = nil
                
                myPlayer.takeDamage(50.0)
                myLogger.error("You have been damaged as a consequence.")
                
            } else {
                myLogger.error("There's nothing to attack in this room.")
            }
            break
            
        case "heal":
            if room.myItems.isEmpty {
                myLogger.error("There aren't any items in this room.")
            } else {
                for obj in room.myItems {
                    if obj is Potion {
                        obj.use()
                        if obj.currentUse == 0 {
                            room.myItems.removeFirst()
                        }
                        break
                    } else if !(obj is Potion) {
                        myLogger.error("You can't use \(obj.name) to heal yourself.")
                        break
                    } else {
                        myLogger.error("There aren't any items in this room.")
                        break
                    }
                }
            }
            
            break
            
        case "xp":
            if room.myItems.isEmpty {
                myLogger.error("There aren't any items in this room.")
            } else {
                for obj in room.myItems {
                    if obj is Bottle {
                        obj.use()
                        room.myItems.removeFirst()
                    } else if !(obj is Bottle) {
                        myLogger.error("You cannot upgrade your XP with a \(obj.name).")
                    } else {
                        myLogger.error("There aren't any items in this room.")
                    }
                }
            }
            break
            
        case "leave":
            myLogger.info("Moving to the next room...")
            if room.myAttackSequence?.enemy == nil {
                room.isDestroyed = true
            } else {
                myLogger.error("You cannot leave until you kill \(room.myMonster?.name ?? "the monster") has been killed.")
            }
            break
            
        case "equip":
            if room.myItems.isEmpty {
                myLogger.error("There is nothing to equip in this room.")
                break
            } else {
                for obj in room.myItems {
                    if obj is Weapon {
                        let useWeapon = obj as! Weapon
                        let getEquipped = useWeapon.equip()
                        if getEquipped {
                            room.myItems.removeLast()
                        } else {
                            break
                        }
                    } else {
                        myLogger.error("\(obj.name) cannot be equipped.")
                    }
                }
            }
            break
            
        case "talk":
            if room.myNPC != nil {
                if room.myNPC?.monologue != [""] {
                    room.myNPC?.sayMonologue(instant: false)
                } else {
                    room.myNPC?.saySomething()
                }
            } else {
                myLogger.error("There isn't anyone here to talk to.")
            }
            break
           
            
        /*
            CLIENT COMMANDS
         */
        
        
        case "exit":
            myLogger.warning("Are you sure you want to exit? (y/n)")
            
            let response = readLine()!
            
            if (response == "y" || response == "yes") {
                settingsHandler.saveSettings()
                
                myLogger.askForLogBeforeExiting()
                
                exit(0)
            } else if (response == "n" || response == "no") {
                myLogger.info("Resuming game...")
                break
            } else {
                myLogger.error("Could not determine action. Resuming game...")
                break
            }
        
        case "save":
            settingsHandler.saveSettings()
            myLogger.info("Player data saved!")
            break
        
        case "clear":
            print("\u{001B}[2J")
            break
            
        case "deleteself":
            settingsHandler.deleteSettings()
            myLogger.info("You died! You deleted yourself from existence.")
            myLogger.info("The game is now over. Exiting to terminal...")
            exit(42)
            break
            
        case "printlog":
            myLogger.info("Printing log until now.")
            myLogger.printLog()
            myLogger.info("Done.")
            
        case "license":
            print(license)
        
        case "help":
            print("""
=== \("List of Commands".bold()) ===
== Getting Information ==
aboutroom - displays information about the room.
aboutself - displays information about oneself.

== \("Interactions".bold()) ==
attack - attacks the monster in the room, if present.
equip - Equip the weapon in the room, if possible.
heal - restores your health by an amount.
talk - talk to a person in the room, if possible.
xp - use an experience-enhancing bottle, if possible.

== \("Miscellaneous".bold()) ==
clear - clears the console screen.
exit - quits the game.
help - displays this screen.
leave - leave the room, if possible.
license - display the game's license statement.
printlog - print the log of the current session as of running the command.
save - saves your player profile.
""")
            break
        
        
        default:
            myLogger.error("\(command) is not a valid command. Type 'help' to see a list of commands.")
            break
        }
    }
}
