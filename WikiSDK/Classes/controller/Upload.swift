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
    private var _led: Led?
    private var _key: String?
    private var _position: Int?
    
    public init(leds: [Led]) {
        self._method   = "POST"
        self._endpoint = "/upload"
        self._json     = WikiController.createStringFromLeds(leds)
        self._led = nil
        self._key = nil
        self._position = nil
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
    
    public var led: Led? {
        get {
            return self._led
        }
    }
    
    public var key: String? {
        get {
            return self._key
        }
    }
    
    public var position: Int? {
        get {
            return self._position
        }
    }

    
}
