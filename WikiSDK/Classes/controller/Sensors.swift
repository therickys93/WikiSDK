//
//  Sensors.swift
//  Pods
//
//  Created by Riccardo Crippa on 2/20/19.
//

import Foundation

public class Sensors: Sendable {
    private var _endpoint: String
    private var _method: String
    private var _led: Led?
    private var _sensor: Sensor?
    private var _key: String?
    private var _position: Int?
    private var _type: String
    
    private init(key: String) {
        self._endpoint = "/sensors/\(key)"
        self._method   = "GET"
        self._key = key
        self._led = nil
        self._position = nil
        self._type = "Sensors"
        self._sensor = nil
    }
    
    public convenience init(key: String, position: Int){
        self.init(key: key)
        self._endpoint = "/sensors/\(key)/\(position)"
        self._position = position
    }
    
    public convenience init(sensor: Sensor){
        self.init(key: sensor.key, position: sensor.position)
        self._sensor = sensor
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
    
    public var sensor: Sensor? {
        get {
            return self._sensor
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
