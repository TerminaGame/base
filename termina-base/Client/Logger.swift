//
//  Logger.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/28/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 Manager of logs.
 
 The logger keeps track of events in Termina and stores them inside of a log for later use.
 */
class Logger {
    
    /**
     An array of all log events.
     
     This array contains all of the strings when the logger functions are executed.
     */
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
     Ask the user to perform an action via a yes/no question.
     
     - Parameters:
        - prompt: The question to be asked. Should be yes/no.
     
     - Returns: True if user responds with yes, False if user does not answer or answers with no.
     */
    func ask(_ prompt: String) -> Bool {
        let fullPrompt = "[Q] \(prompt) (y/n)"
        log.append(fullPrompt)
        print(fullPrompt.cyan())
        let response = readLine()!
        if response == "y" || response == "yes" {
            logToFile("User responded with YES.", "info")
            return true
        } else if response == "n" || response == "no" {
            logToFile("User responded with NO.", "info")
            return false
        } else {
            error("Could not determine response.")
            logToFile("Inrepreting as NO...", "warning")
            return false
        }
    }
    
    /**
     Print a warning to the console.
     
     - Parameters:
        - message: The message to be logged/printed.
     */
    func warning(_ message: String) {
        let fullLogMessage = "[W] \(message)"
        log.append(fullLogMessage)
        print(fullLogMessage.yellow())
    }
    
    /**
     Print an error to the console.
     
     - Parameters:
     - message: The message to be logged/printed.
     */
    func error(_ message: String) {
        let fullLogMessage = "[E] \(message)"
        log.append(fullLogMessage)
        print(fullLogMessage.red().bold())
    }
    
    /**
     Prints information to the console.
     
     - Parameters:
     - message: The message to be logged/printed.
     */
    func info(_ message: String) {
        let fullLogMessage = "[I] \(message)"
        log.append(fullLogMessage)
        print(fullLogMessage.lightBlue())
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
    
    /**
     Ask the user if they want a log exported to `termlog.txt` before performing an action.
     */
    func askForLogBeforeExiting() {
        let getLogPrint = ask("Do you want a printed copy of this session's log?")
        if getLogPrint {
            info("Log will be saved to termlog.txt.")
            printLog()
        } else {
            error("Operation aborted!")
        }
    }
    
}
