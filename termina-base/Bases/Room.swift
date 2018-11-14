//
//  Room.swift
//  Termina
//
//  Created by Marquis Kurt on 10/18/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Base element that can contain items and a monster, as well as its name generators and attack scenes.
 
 Rooms make up the core of the game. The `Room` class creates a space where players can interact with items.
 Rooms can contain any of the following items:
 - Monsters
 - NPCs
 - Items (Potions, Bottles, Weapons)
 */
class Room {
    /**
     Optional monster.
     */
    var myMonster: Monster?
    
    /**
     Optional NPC.
     */
    var myNPC: NPC?
    
    /**
     Optional attack sequence.
     
     If `myMonster` is not a nil object, the attack sequence will construct itself with the player and monster.
     */
    var myAttackSequence: AttackScene?
    
    /**
     An array listing the items available to pick up or use.
     */
    var myItems = [Item]()
    
    /**
     Boolean value to determine if room is done being used.
     
     This value cna be used to break a loop or to cause a change in the room.
     */
    var isDestroyed = false
    
    /**
     Name generator for entities in room.
     */
    let myNameGen = NameGenerator()
    
    /**
     Attempt to attack any entities in the room.
     */
    func attackHere() {
        if myAttackSequence?.enemy != nil {
            myAttackSequence?.attack()
        } else if myNPC != nil {
            myNPC?.takeDamage(1)
            myLogger.error("You killed \((myNPC?.name ?? "NPC").bold())! You monster...")
            myAttackSequence?.player?.takeDamage(50)
            myLogger.error("You've been injured as a consequence! (-50)")
        } else {
            myLogger.error("There's nothing to attack in this room.")
        }
    }
    
    /**
     Lists everything available in the room.
     
     Identifies any entities in the room, its protected status, and items that the room has.
     */
    func listProperties() {
        print("=== \("Current Room".bold()) ===".foregroundColor(TerminalColor.orange3))
        if myAttackSequence?.protectedZone ?? false {
            print("Protected Zone".cyan().blink())
        }
        if myAttackSequence?.enemy != nil {
            let monsterLevel = String(myMonster!.level)
            let monsterName = myMonster?.name
            print("\(monsterName ?? "MonsterError") v.\(monsterLevel) (Enemy)".red().bold())
            
            if myPlayer.level <= 3 {
                print("Use the \("attack".bold()) command to catch the error!".green())
            }
            
        } else if myNPC != nil {
            print("\(myNPC?.name ?? "NPC") (NPC)".bold().lightGray())
            
            if myPlayer.level <= 3 {
                print("Use the \("talk".bold()) command to interact!".green())
            }
            
        } else {
            print("There are no entities here.")
        }
        
        if myItems.isEmpty != true {
            print("Items: ".bold())
            for obj in myItems {
                if obj is Weapon {
                    let thisWeapon = obj as! Weapon
                    let weaponLevel = String(thisWeapon.level!)
                    print(" - \(thisWeapon.name) v.\(weaponLevel)".foregroundColor(TerminalColor.gold3_2))
                } else if obj is Bottle {
                    let bottleTemp = obj as? Bottle
                    print(" - \(bottleTemp?.name ?? "Version Update Patcher") v.\(bottleTemp?.effect ?? 1) (Single-Use)".foregroundColor(TerminalColor.purple_3))
                } else {
                    print(" - \(obj.name) v.\(obj.effect) (\(obj.currentUse - 1) uses left)".foregroundColor(TerminalColor.purple_3))
                }
            }
        } else {
            print("There are no items here.")
        }
        print("\n")
    }
    
    /**
     Attempt to use any of the items in the room.
     
     Accepted types:
     - potion
     - bottle
     - weapon
     
     - Parameters:
        - which: the type of item to target
     */
    func useItemsHere(which: String) {
        if myItems.isEmpty {
            myLogger.error("There are no items here.")
        } else {
            switch which {
            case "potion":
                potionLoop: for item in myItems {
                    if item is Potion {
                        item.use()
                        if item.currentUse <= 0 {
                            myItems.removeFirst()
                        }
                        break potionLoop
                    } else {
                        myLogger.error ("You can't use \(item.name) to heal yourself.")
                        break
                    }
                }
                break
            case "bottle":
                patchLoop: for item in myItems {
                    if item is Bottle {
                        item.use()
                        if item.currentUse <= 0 {
                            myItems.removeFirst()
                        }
                        break patchLoop
                    } else {
                        myLogger.error("You can't use \(item.name) to patch yourself.")
                        break
                    }
                }
                break
            case "weapon":
                weaponLoop: for item in myItems {
                    if item is Weapon {
                        let weapon = item as? Weapon
                        let equipWeapon = weapon?.equip() ?? false
                        if equipWeapon {
                            myItems.removeLast()
                            break weaponLoop
                        } else {
                            break weaponLoop
                        }
                    } else {
                        myLogger.error("You can't equip \(item.name)")
                    }
                }
                
                break
            default:
                myLogger.logToFile("The case \(which) doesn't match any parameters listed.", "error")
                break
            }
        }
        
    }
    
    
    
    
    
    
    
    /**
     Constructs the Room object. Randomly adds monsters and an attack sequence if necessary.
     Also adds healing potions, weapons, and experience bottles as necessary.
     
     - Parameters:
        - player: The player to put into the room
        - monster: The monster to insert into the room. If set to `nil`, will generate randomly.
        - cmd: The command interpreter to run the "whereami" command. If set to `nil`, will not display command.
     */
    init(_ player: Player, _ monster: Monster?, _ cmd: CommandInterpreter?) {
        let chance = Int.random(in: 0 ... 9)
        
        if monster != nil {
            myMonster = monster
            myAttackSequence = AttackScene(player, myMonster!)
        } else {
            if (chance > 4) {
                myNPC = nil
                if monster != nil {
                    myMonster = monster
                } else {
                    if player.level < 8 {
                        myMonster = Monster(myNameGen.generateMonsterName(), Int.random(in: 1 ... 7))
                    } else {
                        myMonster = Monster(myNameGen.generateMonsterName(), Int.random(in: player.level - 7 ... player.level + 15))
                    }
                }
                myAttackSequence = AttackScene(player, myMonster!)
            } else {
                myNPC = NPC(myNameGen.generateNameNPC())
            }
        }
        
        
        
        if (chance >= 4) {
            let selectRandomHelper = Int.random(in: 0 ... 3)
            if selectRandomHelper <= 2 {
                let myPotion = Potion("Health Hotfix", player)
                myItems.append(myPotion)
            } else if selectRandomHelper == 3 {
                let myBottle = Bottle("Version Update Patcher", player)
                myItems.append(myBottle)
            }
            
        }
        
        if (chance >= 3 && chance <= 6) {
            if player.level < 16 {
                let myWeapon = Weapon(myNameGen.generateWeaponName(), Int.random(in: 1 ... 15), player)
                myItems.append(myWeapon)
            } else {
                let myWeapon = Weapon(myNameGen.generateWeaponName(), Int.random(in: 1 ... player.level - 15), player)
                myItems.append(myWeapon)
            }
            
        }
        
        if cmd != nil {
            listProperties()
        }
    }
    
}
