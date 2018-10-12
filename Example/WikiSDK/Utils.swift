//
//  Utils.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

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
    
    public static func readFile(file: String) -> [String] {
        let content = Utils.readContentOfFile(file: file)
        return content.split(separator: "\n").map(String.init)
    }
    
}
