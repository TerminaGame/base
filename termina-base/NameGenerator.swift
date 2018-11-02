//
//  NameGenerator.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/23/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Generator for weapon and monster names.
 */
class NameGenerator {
    
    let weaponPrefix = "NS"
    let monsterSuffix = "Error"
    
    let weaponList = [
        "App",
        "File",
        "Bundle",
        "Kit",
        "Implementer",
        "Object",
        "Rect",
        "Null",
        "Area",
        "Coordinate",
        "Sprite",
        "Scene",
        "Node",
        "Class",
        "Home",
        "Core",
        "Message",
        "Map",
        "Multi",
        ""
    ]
    
    let weaponSuffix = [
        "Delegate",
        "Manager",
        "Handler",
        "Buffer",
        "Array",
        "Service",
        "Bundle",
        ""
    ]
    
    let monsterList = [
        "Null",
        "Integer",
        "String",
        "Format",
        "Array",
        "Guard",
        "Assignment"
    ]
    
    let monsterAddition = [
        "Pointer",
        "Value",
        "Wrap",
        "Call",
        "Invalid",
        "Conversion"
    ]
    
    let namesNPC = [
        "John",
        "Manny",
        "Douglas",
        "Linus",
        "Peter",
        "Mike",
        "Aaron",
        "Daniel",
        "Samuel",
        "Henry",
        "Joseph",
        "Adam",
        "Thomas",
        "Tim",
        "Andrew",
        "Wallace",
        "Nicholas",
        "Gordon",
        "Calvin",
        "Kelvin",
        "Keith",
        "Jim",
        "Mumbo",
        "Grian",
        "Alan",
        "Martin",
        "Christopher",
        "Norman",
        "Beowulf",
        "Shane",
        "Cave",
        "null object 14",
        
        "Andromeda",
        "Michelle",
        "Alize",
        "Monique",
        "Susan",
        "Allison",
        "Amy",
        "Natalie",
        "Nova",
        "Chloe",
        "Dupris",
        "Claris",
        "Maria",
        "Leah",
        "Sarah",
        "Mia",
        "Jill",
        "Sierra",
        "Scotia",
        "Kate",
        "Caroline",
        "Catherine",
        "Mystique",
        "Chrysanthemum",
        "null object 16",
        "Monica",
        "Anna",
        "Esther",
        "Quinn"
    ]
    
    /**
     Generates a weapon name from random elements of a list with its prefix.
     
     - Returns: Weapon name as a String
     */
    func generateWeaponName() -> String {
        return weaponPrefix + (weaponList.randomElement() ?? "") + (weaponSuffix.randomElement() ?? "")
    }
    
    /**
     Generates a monster name from random elements of a list with its suffix.
     
     - Returns: Monster name as a String
     */
    func generateMonsterName() -> String {
        return (monsterList.randomElement() ?? "") + (monsterAddition.randomElement() ?? "") + monsterSuffix
    }
    
    /**
     Picks a name from an array randomly.
     
     - Returns: NPC name as a String
     */
    func generateNameNPC() -> String {
        return namesNPC.randomElement() ?? "NPC"
    }
    
}
