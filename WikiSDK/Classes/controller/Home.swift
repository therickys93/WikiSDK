//
//  Home.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/13/18.
//

import Foundation

public class Home: Sendable {
    private var _method: String
    private var _endpoint: String
    private var _led: Led?
    private var _key: String?
    private var _position: Int?
    
    public init() {
        self._method   = "GET"
        self._endpoint = "/"
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
}
