//
//  Wiki.swift
//  WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

struct Wiki {
    struct Constants {
        static let DBFILE                         = "wiki.json"
        static let NO_LIGHTS_FOUND                = "Nessun Accessorio trovato"
        static let FILE_SEPARATOR_CHAR: Character = "\n"
        static let FILE_SEPARATOR_STRING: String  = "\n"
        
    }
    struct Controllers {
        struct WikiController {
            static let TITLE       = "Wiki"
            static let DEFAULT_URL = "http://controller.wiki.home"
        }
        struct LightsController {
            static let TITLE                 = "Configura Casa"
            static let CELL_REUSE_IDENTIFIER = "CellReuseIdentifier"
        }
        
    }
}
