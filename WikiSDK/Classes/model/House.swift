//
//  House.swift
//  Pods-WikiSDK_Example
//
//  Created by Riccardo Crippa on 10/13/18.
//

import Foundation

public class House {
    private var _leds: [Led]
    
    public init() {
        self._leds = [Led]()
    }
    
    public init(leds: [Led]){
        self._leds = leds
    }
    
    public var led: [Led] {
        get {
            return self._leds
        }
        set {
            self._leds = newValue
        }
    }
    
    public func ledCount() -> Int {
        return self._leds.count
    }
    
    public func getLedAtPosition(_ position: Int) -> Led {
        return self._leds[position]
    }
    
    public func removeLedAt(_ index: Int) {
        self._leds.remove(at: index)
    }
    
    public func removeLedByName(_ name: String) {
        if let index = self._leds.firstIndex(where: { $0.name == name }) {
            self.removeLedAt(index)
        }
    }
    
    public func getLedByName(_ name: String) -> Led? {
        for led in self._leds {
            if(led.name == name){
                return led
            }
        }
        return nil
    }
    
    public func addLed(_ led: Led) -> Bool {
        var ok = true
        for l in self._leds {
            if l.name == led.name || (l.position == led.position && led.key == l.key) {
                // do nothing a led is already added
                ok = false
            }
        }
        if ok {
            self._leds.append(led)
        }
        return ok
    }
    
}
