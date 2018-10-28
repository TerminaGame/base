//
//  Logger.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/28/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

class Logger {
    
    var log = [String]()
    
    /**
     Create a log file of all logging messages. Overwrites any older log files.
     */
    func printLog() {
        let logPath = try! Folder(path: "")
        
        var fullLogAsString = ""
        
        for message in log {
            fullLogAsString += "\(message)\n"
        }
        
        try! logPath.createFile(named: "termlog.txt").write(string: fullLogAsString)
    }
    
    /**
     Print a warning to the console.
     
     - Parameters:
        - message: The message to be logged/printed.
     */
    func warning(_ message: String) {
        let fullLogMessage = "[W] \(message)"
        log.append(fullLogMessage)
        print(fullLogMessage)
    }
    
    /**
     Print an error to the console.
     
     - Parameters:
     - message: The message to be logged/printed.
     */
    func error(_ message: String) {
        let fullLogMessage = "[E] \(message)"
        log.append(fullLogMessage)
        print(fullLogMessage)
    }
    
    /**
     Prints information to the console.
     
     - Parameters:
     - message: The message to be logged/printed.
     */
    func info(_ message: String) {
        let fullLogMessage = "[I] \(message)"
        log.append(fullLogMessage)
        print(fullLogMessage)
    }
    
}
