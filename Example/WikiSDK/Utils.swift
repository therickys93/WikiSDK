//
//  Utils.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import WikiSDK

public class Utils {
    
    public static func readContentOfFile(file: String) -> String {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            if let out = try? String(contentsOf: fileURL, encoding: .utf8) {
                return out
            }
        }
        return ""
    }
    
    public static func writeContent(_ content: String, toFile file: String, appending append: Bool) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            if append {
                if FileManager.default.fileExists(atPath: fileURL.path){
                    do {
                        let fileHandle = try FileHandle(forWritingTo: fileURL)
                        fileHandle.seekToEndOfFile()
                        fileHandle.write(content.data(using: .utf8, allowLossyConversion: false)!)
                        fileHandle.closeFile()
                    } catch {
                        print("Error writing to File")
                    }
                } else {
                    try? content.write(to: fileURL, atomically: true, encoding: .utf8)
                }
            } else {
                try? content.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        }
    }
    
    private static func timestamp() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return formatter.string(from: date)
    }
    
    public static func writeToLog(_ content: String){
        let newContent = "[\(timestamp())] \(content)\r\n"
        Utils.writeContent(newContent, toFile: Wiki.Constants.LOGFILE, appending: true)
    }
    
    public static func readFromLog() -> [String] {
        return Utils.readFile(file: Wiki.Constants.LOGFILE)
    }
    
    public static func readFile(file: String) -> [String] {
        let content = Utils.readContentOfFile(file: file)
        return content.split(separator: Wiki.Constants.FILE_SEPARATOR_CHAR).map(String.init)
    }
    
    public static func readLeds(file: String) -> [Led] {
        return WikiController.parseLedsFromString(Utils.readContentOfFile(file: file))
    }
    
    public static func saveLeds(_ leds: [Led], inFile file: String) {
        let content = WikiController.createStringFromLeds(leds)
        Utils.writeContent(content, toFile: file, appending: false)
    }
    
    public static func readMacro(file: String) -> [Macro] {
        return Macro.createMacrosFromString(Utils.readContentOfFile(file: file))
    }
    
    public static func saveMacros(_ macros: [Macro], inFile file: String){
        let content = Macro.createStringFromMacros(macros)
        return Utils.writeContent(content, toFile: file, appending: false)
    }
    
    public static func saveWikiControllerURL(_ url: String) {
        UserDefaults.standard.set(url, forKey: Wiki.Controllers.WikiController.DEFAULT_KEY)
    }
    
    public static func loadWikiControllerURL() -> String {
        return UserDefaults.standard.string(forKey: Wiki.Controllers.WikiController.DEFAULT_KEY) ?? Wiki.Controllers.WikiController.DEFAULT_URL
    }
    
    public static func saveWikiServerURL(_ url: String) {
        UserDefaults.standard.set(url, forKey: Wiki.Controllers.WikiServer.DEFAULT_URL_KEY)
    }
    
    public static func loadWikiServerURL() -> String {
        return UserDefaults.standard.string(forKey: Wiki.Controllers.WikiServer.DEFAULT_URL_KEY) ??
            Wiki.Controllers.WikiServer.DEFAULT_URL_VALUE
    }
    
    public static func saveWikiServerUser(_ user: String) {
        UserDefaults.standard.set(user, forKey: Wiki.Controllers.WikiServer.DEFAULT_USER_KEY)
    }
    
    public static func loadWikiServerUser() -> String {
        return UserDefaults.standard.string(forKey: Wiki.Controllers.WikiServer.DEFAULT_USER_KEY) ??
            Wiki.Controllers.WikiServer.DEFAULT_USER_VALUE
    }
    
    public static func saveParseURL(_ url: String) {
        UserDefaults.standard.set(url, forKey: Wiki.Controllers.WikiController.KEY_PARSE_URL)
    }
    
    public static func loadParseURL() -> String {
        return UserDefaults.standard.string(forKey: Wiki.Controllers.WikiController.KEY_PARSE_URL) ?? Wiki.Controllers.WikiController.DEFAULT_PARSE_URL
    }
    
    public static func saveParseAppId(_ appId: String) {
        
    }
    
    public static func loadParseAppId() -> String {
        return ""
    }
    
    public static func saveParseClassName(_ className: String) {
        
    }
    
    public static func loadParseClassName() -> String {
        return ""
    }
    
    public static func saveParseField(_ field: String) {
        
    }
    
    public static func loadParseField() -> String {
        return ""
    }
    

}
