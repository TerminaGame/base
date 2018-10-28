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
    
    /**
     Add a log message to the log file without displaying it to the console.
     
     - Parameters:
        - message: The message to be logged/printed.
        - type: The type of log message (warning, error, info).
     */
    func logToFile(_ message: String, _ type: String) {
        var fullLogMessage = ""
        if type == "warning" {
            fullLogMessage = "[W] \(message)"
        } else if type == "error" {
            fullLogMessage = "[E] \(message)"
        } else if type == "info" {
            fullLogMessage = "[I] \(message)"
        } else {
            error("Type of log message isn't specified, so it will not be printed to the log file.")
        }
        
        log.append(fullLogMessage)
    }
    
}
