//
//  Upload.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/16/18.
//

import Foundation

public class Upload: Sendable {
    
    private var _endpoint: String
    private var _method: String
    private var _json: String
    
    public init(leds: [Led]) {
        self._method   = "POST"
        self._endpoint = "/upload"
        self._json     = WikiController.createStringFromLeds(leds)
    }
    
    public var endpoint: String {
        get {
            return self._endpoint
        }
    }
    
    public var method: String {
        get {
            return self._method
        }
    }
    
    public var json: String? {
        get {
            return self._json
        }
    }
    
}
