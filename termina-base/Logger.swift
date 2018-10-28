//
//  Logger.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/28/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

class Logger {
    /**
     Print a warning to the console.
     
     - Parameters:
        - message: The message to be logged/printed.
     */
    func warning(_ message: String) {
        print("[W] \(message)")
    }
    
    /**
     Print an error to the console.
     
     - Parameters:
     - message: The message to be logged/printed.
     */
    func error(_ message: String) {
        print("[E] \(message)")
    }
    
    /**
     Prints information to the console.
     
     - Parameters:
     - message: The message to be logged/printed.
     */
    func info(_ message: String) {
        print("[I] \(message)")
    }
    
}
