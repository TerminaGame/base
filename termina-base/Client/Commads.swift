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
            room.listProperties()
            break
        
        case "whoami":
            myPlayer.listProperties()
            break
        
        // Alternative command for the geeks
        case "ls":
            room.listProperties()
            myPlayer.listProperties()
            break
            
        /*
            INTERACTIONS
         */
        case "attack":
            room.attackHere()
            break
            
        case "heal":
            room.useItemsHere(which: "potion")
            break
            
        // Alternative command for the geeks
        case "apply-hotfix":
            room.useItemsHere(which: "potion")
            break
            
        case "xp":
            room.useItemsHere(which: "bottle")
            break
         
        // Alternative command for the geeks
        case "patch":
            room.useItemsHere(which: "bottle")
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
            room.useItemsHere(which: "weapon")
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
                if CommandLine.arguments.count != 1 {
                    if CommandLine.arguments[1] == "--boss-battle-only" {
                        myPlayer.level = settingsHandler.storedLevel
                    }
                }
                settingsHandler.saveSettings()
                myLogger.askForLogBeforeExiting()
                exit(0)
            } else {
                myLogger.info("Resuming game...")
            }
            break
        
        // Alternative command
        case "exit --force":
            myLogger.info("Exiting game without prompt (log save in termlog.txt)...")
            
            if CommandLine.arguments[1] == "--boss-battle-only" {
                myPlayer.level = settingsHandler.storedLevel
            }
            
            settingsHandler.saveSettings()
            myLogger.printLog()
            exit(0)
            break
        
        case "save":
            settingsHandler.saveSettings()
            myLogger.info("Player data saved!")
            break
        
        case "clear":
            print("\u{001B}[2J")
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
            If you need more help, go here: \("https://terminagame.github.io/help/".cyan().underline()).
            
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
                myLogger.error("There is no previous command to run!")
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
            
        case "termina":
            myLogger.warning("\(myPlayer.name)... why are you here?")
            break
            
        case "die":
            myLogger.error("Screaming into the void cannot help you here.")
            break
        
        case "deleteself":
            settingsHandler.deleteSettings()
            myLogger.info("You died! You deleted yourself from existence.")
            myLogger.info("The game is now over. Exiting to terminal...")
            exit(42)
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
