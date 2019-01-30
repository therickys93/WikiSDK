//
//  OpenClose.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/14/18.
//

import Foundation

public class OpenClose: Sendable {
    private var _endpoint: String
    private var _method: String
    private var _led: Led?
    private var _key: String?
    private var _position: Int?
    private var _type: String
    
    public init(key: String, position: Int) {
        self._method = "GET"
        self._endpoint = "/openclose/\(key)/\(position)"
        self._key = key
        self._position = position
        self._type = "Apri/Chiudi"
    }
    
    public convenience init(led: Led) {
        self.init(key: led.key, position: led.position)
        self._led = led
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
            return nil
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
    
    public var type: String {
        get {
            return self._type
        }
    }
}
