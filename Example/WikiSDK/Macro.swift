//
//  Macro.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import WikiSDK

public class Macro {
    var name: String
    var sendable: [Sendable]
    
    public init(name: String, sendable: [Sendable]) {
        self.name = name
        self.sendable = sendable
    }
    
    public static func createStringFromMacros(_ macros: [Macro]) -> String {
        var json = "["
        var removeMacro = false
        var removeSendable = false
        for macro in macros {
            json += "{\"name\": \"\(macro.name)\", \"sendable\": ["
            for sendable in macro.sendable {
                if let name = sendable.led?.name, let key = sendable.led?.key, let position = sendable.led?.position {
                    json += "{\"type\": \"\(sendable.type)\",\"name\": \"\(name)\", \"key\": \"\(key)\", \"position\": \(position)},"
                }
                removeSendable = true
            }
            if removeSendable {
                json.remove(at: json.index(before: json.endIndex))
            }
            json += "]},"
            removeMacro = true
        }
        if removeMacro {
            json.remove(at: json.index(before: json.endIndex))
        }
        json += "]"
        return json
    }
    
    public static func createMacrosFromString(_ string: String) -> [Macro] {
        return [Macro]()
    }
}
