//
//  Sensor.swift
//  Pods
//
//  Created by Riccardo Crippa on 2/20/19.
//

import Foundation

public class Sensor {
    
    private var _name: String
    private var _key: String
    private var _position: Int
    
    public init(){
        self._name     = ""
        self._key      = ""
        self._position = -1
    }
    
    public init(name: String, key: String, position: Int) {
        self._name     = name
        self._key      = key
        self._position = position
    }
    
    public var name: String {
        get {
            return self._name
        }
        set {
            self._name = newValue
        }
    }
    
    public var key: String {
        get {
            return self._key
        }
        set {
            self._key = newValue
        }
    }
    
    public var position: Int {
        get {
            return self._position
        }
        set {
            self._position = newValue
        }
    }
    
}
