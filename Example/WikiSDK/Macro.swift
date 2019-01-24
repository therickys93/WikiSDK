//
//  Macro.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/24/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import WikiSDK

class Macro {
    var name: String
    var sendable: [Sendable]
    
    init(name: String, sendable: [Sendable]) {
        self.name = name
        self.sendable = sendable
    }
}
