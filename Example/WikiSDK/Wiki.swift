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
        static let DBFILE                         = "Wiki_Home_Configuration.json"
        static let LOGFILE                        = "Wiki_iOS_logfile.txt"
        static let MACROFILE                      = "Wiki_Macro_Configuration.json"
        static let NO_LIGHTS_FOUND                = "Nessun Accessorio trovato"
        static let FILE_SEPARATOR_CHAR: Character = "\n"
        static let FILE_SEPARATOR_STRING: String  = "\n"
        
    }
    struct Controllers {
        struct WikiController {
            static let TITLE            = "Wiki"
            static let DEFAULT_URL      = "http://controller.wiki.home"
            static let DEFAULT_KEY      = "WIKICONTROLLER_URL"
            static let PARSE_APP_ID     = "therickys93-wiki"
            static let PARSE_URL        = "https://therickys93-wiki.herokuapp.com/parse"
            static let PARSE_CLASS_NAME = "Commands"
            static let PARSE_FIELD      = "url"
        }
        struct LightsController {
            static let TITLE                 = "Configura Casa"
            static let CELL_REUSE_IDENTIFIER = "CellReuseIdentifier"
        }
        struct WikiServer {
            static let TITLE              = "Wiki AI"
            static let DEFAULT_URL_VALUE  = "http://server.wiki.home/v2/wiki"
            static let DEFAULT_URL_KEY    = "WIKISERVER_URL"
            static let DEFAULT_USER_KEY   = "WIKISERVER_USER"
            static let DEFAULT_USER_VALUE = "therickys93"
        }
    }
}
