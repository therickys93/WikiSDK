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
    
    public static func writeContent(_ content: String, toFile file: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            try? content.write(to: fileURL, atomically: true, encoding: .utf8)
        }
    }
    
    private static func timestamp() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return formatter.string(from: date)
    }
    
    public static func writeToLog(_ content: String){
        let newContent = "[\(timestamp())] \(content)"
        Utils.writeContent(newContent, toFile: Wiki.Constants.LOGFILE)
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
        Utils.writeContent(content, toFile: file)
    }
    
    public static func saveWikiControllerURL(_ url: String) {
        UserDefaults.standard.set(url, forKey: Wiki.Controllers.WikiController.DEFAULT_KEY)
    }
    
    public static func loadWikiControllerURL() -> String {
        return UserDefaults.standard.string(forKey: Wiki.Controllers.WikiController.DEFAULT_KEY) ?? Wiki.Controllers.WikiController.DEFAULT_URL
    }
}
