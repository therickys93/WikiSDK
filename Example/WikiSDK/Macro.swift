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
        var macros = [Macro]()
        var sendable = [Sendable]()
        do {
            let json = try JSONSerialization.jsonObject(with: string.data(using: .utf8)!, options: .allowFragments) as? [[String : Any]]
            for i in 0..<json!.count {
                let macroname = json?[i]["name"] as? String
                let send  = json?[i]["sendable"] as? [[String : Any]]
                for j in 0..<send!.count {
                    let name = send?[j]["name"] as? String
                    let key = send?[j]["key"] as? String
                    let position = send?[j]["position"] as? Int
                    let type = send?[j]["type"] as? String
                    switch type {
                    case "Accendi":
                        sendable.append(On(led: Led(name: name!, key: key!, position: position!)))
                        break
                    case "Spegni":
                        sendable.append(Off(led: Led(name: name!, key: key!, position: position!)))
                        break
                    case "Apri/Chiudi":
                        sendable.append(OpenClose(led: Led(name: name!, key: key!, position: position!)))
                        break
                    default:
                        break
                    }
                }
                macros.append(Macro(name: macroname!, sendable: sendable))
                sendable.removeAll()
            }
        } catch {
            sendable.removeAll()
            macros.removeAll()
        }
        return macros
    }
}
