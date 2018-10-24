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
        "Area"
        
    ]
    
    let weaponSuffix = [
        "Delegate",
        "Manager",
        "Handler",
        "Buffer",
        "Array",
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
    
}
