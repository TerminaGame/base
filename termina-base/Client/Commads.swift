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
 
 The command interpreter is responsible for handling, parsing, and executing commands given to it, either by user input or programmatically. It will try to store the last command used for "quick-access".
 */
class CommandInterpreter {
    
    /**
     The last successfully-parsed command to be executed.
     
     This variable is necessary for enabling the "quick-access" mode by pressing Enter to run this command.
     */
    var lastCommand = ""
    
    /**
     Gets the command or list of commands from a user and parses them.
     
     - Parameters:
        - whichRoom: The room to parse the commands for
        - settings: The settings manager to handling data
        - skipCommandLogging: Whether to skip flagging the commands in the command log
     */
    func getCommandAndParse(whichRoom: Room, settings: SettingsManager, skipCommandLogging: Bool) {
        // Get the player's input and parse the command into the interpreter.
        print("\nWhat would you like to do? Type a command or a set seperated by a semicolon:")
        let commandInput = readLine(strippingNewline: true)!
        if commandInput.contains(";") {
            myLogger.logToFile("Input is a set of commands! Parsing each command...", "info")
            var commandArray = commandInput.components(separatedBy: ";")
            if let emptyArrayIndex = commandArray.index(of: ";") {
                commandArray.remove(at: emptyArrayIndex)
            }
            
            var parseCommandCounter = 0
            for commandInArray in commandArray {
                myLogger.logToFile("Running command \(commandInArray.uppercased()) (\(parseCommandCounter))", "info")
                parseCommand(commandInArray, whichRoom, settings, skipCommandLogging: skipCommandLogging)
                parseCommandCounter += 1
            }
            myLogger.logToFile("Done!", "info")
        } else {
            parseCommand(commandInput, whichRoom, vm, skipCommandLogging: skipCommandLogging)
        }
    }
    
    /**
     Interpret the given input to perform an action. If the command parsing is successful, the command is stored into `lastCommand` for future use.
     
     If the player is attempting to run the same command as the last time, this will attempt to parse the command stored in `lastCommand`.
     
     - Parameters:
        - command: The command to try running
        - room: The room the player is located in.
        - settingsHandler: The settings manager to save and load player data.
        - skipCommandLogging: Whether to store the run command in the command log.
     */
    func parseCommand(_ command: String, _ room: Room, _ settingsHandler: SettingsManager, skipCommandLogging: Bool) {
        
        switch command {
            
        /*
            GETTING INFORMATION
        */
            
        case "whereami":
            print("=== \("Current Room".bold()) ===".foregroundColor(TerminalColor.orange3))
            if room.myAttackSequence?.protectedZone ?? false {
                print("Protected Zone".cyan().blink())
            }
            if room.myAttackSequence?.enemy != nil {
                let monsterLevel = String(room.myMonster!.level)
                let monsterName = room.myMonster?.name
                print("\(monsterName ?? "Monster") v.\(monsterLevel) (Enemy)".red().bold())
                
                if myPlayer.level <= 3 {
                    print("Use the \("attack".bold()) command to catch the error!".green())
                }
                
            } else if room.myNPC != nil {
                print("\(room.myNPC?.name ?? "NPC") (NPC)".bold())
                
                if myPlayer.level <= 3 {
                    print("Use the \("talk".bold()) command to interact!".green())
                }
                
            } else {
                print("There are no entities here.")
            }
            
            if room.myItems.isEmpty != true {
                print("Items: ".bold())
                for obj in room.myItems {
                    if obj is Weapon {
                        let thisWeapon = obj as! Weapon
                        let weaponLevel = String(thisWeapon.level!)
                        print(" - \(thisWeapon.name) v.\(weaponLevel)".foregroundColor(TerminalColor.gold3_2))
                    } else {
                        print(" - \(obj.name) v.\(obj.effect) (\(obj.currentUse) uses left)".foregroundColor(TerminalColor.purple_3))
                    }
                }
            } else {
                print("There are no items here.")
            }
            print("\n")
            break
        
        case "whoami":
            let myLevel = String(myPlayer.level)
            let myExperience = String(myPlayer.experience)
            print("=== \(myPlayer.name.bold()) ===".foregroundColor(TerminalColor.orange3))
            print("Version \(myLevel)")
            print("Patch Number: \(myExperience)/25".cyan())
            if myPlayer.health <= 10.0 {
                 print("Health: \(String(myPlayer.health).red().blink().bold())/\(myPlayer.maximumHealth)".yellow())
            } else {
                print("Health: \(myPlayer.health)/\(myPlayer.maximumHealth)".yellow())
            }
            
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
                myLogger.error("You have been injured as a consequence (-50).")
                
            } else {
                myLogger.error("There's nothing to attack in this room.")
            }
            break
            
        case "heal":
            if room.myItems.isEmpty {
                myLogger.error("There aren't any items in this room.")
            } else {
                equipLoop: for obj in room.myItems {
                    if obj is Potion {
                        obj.use()
                        if obj.currentUse == 0 {
                            room.myItems.removeFirst()
                        }
                        break equipLoop
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
                xpLoop: for obj in room.myItems {
                    if obj is Bottle {
                        obj.use()
                        room.myItems.removeFirst()
                        break xpLoop
                    } else if !(obj is Bottle) {
                        myLogger.error("You cannot upgrade your XP with a \(obj.name).")
                    } else {
                        myLogger.error("There aren't any items in this room.")
                    }
                }
            }
            break
            
        case "leave":
            myLogger.info("Leaving this room...")
            if room.myAttackSequence?.enemy == nil {
                room.isDestroyed = true
            } else {
                myLogger.error("You cannot leave until \(room.myMonster?.name ?? "the monster") has been caught or pacified!")
            }
            break
            
        case "equip":
            if room.myItems.isEmpty {
                myLogger.error("There is nothing to equip in this room.")
                break
            } else {
                weaponLoop: for obj in room.myItems {
                    if obj is Weapon {
                        let useWeapon = obj as! Weapon
                        let getEquipped = useWeapon.equip()
                        if getEquipped {
                            room.myItems.removeLast()
                            break weaponLoop
                        } else {
                            break weaponLoop
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
                    room.myNPC?.saySomething(nil)
                }
            } else {
                myLogger.error("There isn't anyone here to talk to.")
            }
            break
            
        case "pacify":
            if room.myAttackSequence?.enemy != nil {
                room.myMonster?.pacify(myPlayer)
                room.myAttackSequence?.enemy = nil
            } else {
                myLogger.error("There isn't an error to pacify.")
            }
            break
           
            
        /*
            CLIENT COMMANDS
         */
        
        
        case "exit":
            
            let getExit = myLogger.ask("Are you sure you want to exit?")
            
            if getExit {
                settingsHandler.saveSettings()
                myLogger.askForLogBeforeExiting()
                exit(0)
            } else {
                myLogger.info("Resuming game...")
            }
            break
        
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
            print("\n" + license + "\n")
            
        case "changename":
            myLogger.info("Type a new name to change to or press Enter to abort.")
            
            let newPlayerName = readLine(strippingNewline: true)!
            
            if newPlayerName != "" {
                myPlayer.name = newPlayerName
                settingsHandler.saveSettings()
                myLogger.info("Player name changed to \(newPlayerName)!")
            } else {
                myLogger.error("User aborted operation.")
            }
        
        case "help":
            print("""
            === \("List of Commands".bold().green()) ===
            \("To run a previous command, press Enter.".foregroundColor(TerminalColor.orange3))
            
            == \("Game Commands".bold().green()) ==
            attack - attacks the monster in the room, if present.
            equip - Equip the weapon in the room, if possible.
            heal - restores your health by an amount.
            leave - leave the room, if possible.
            pacify - attempt to make peace with an error, if possible.
            talk - talk to a person in the room, if possible.
            xp - use an experience-enhancing bottle, if possible.
            whereami - displays information about the room.
            whoami - displays information about oneself.

            == \("Client Commands".bold().green()) ==
            changename - change your name to something else.
            clear - clears the console screen.
            exit - quits the game.
            help - displays this screen.
            license - display the game's license statement.
            save - saves your player profile.
            """)
            break
        
        case "":
            if lastCommand != "" {
                myLogger.logToFile("Running last known command (\(lastCommand))", "info")
                parseCommand(lastCommand, room, settingsHandler, skipCommandLogging: false)
            } else {
                myLogger.error("There is no previous command to parse!")
            }
            
            break
            
            
            
        /*
             MISC. COMMANDS
        */
        case "killself":
            myLogger.error("You cannot kill yourself.")
            break
            
        case "flee":
            if room.myAttackSequence?.enemy != nil {
                if myPlayer.level ?? 1 > room.myMonster?.level ?? 1 {
                    myLogger.error("You cannot flee. But, you \("could".underline()) pacify \(room.myMonster?.name ?? "the enemy")...")
                }
                else {
                    myLogger.error("You cannot flee. Be brave!")
                }
            }
            
            break
            
        case "die":
            myLogger.error("Screaming into the void cannot help you here.")
            break
        
            
            
        case "cheesecake":
            if room.myNPC != nil {
                room.myNPC?.cheesecake()
            } else {
                myLogger.error("What in the world are you doing?")
            }
            break
        
        default:
            myLogger.error("\"\(command)\" is not a valid command. Type \("help".green()) to see a list of commands.")
            break
        }
        
        
        if command != "" && !skipCommandLogging {
            lastCommand = command
        }
    }
}
