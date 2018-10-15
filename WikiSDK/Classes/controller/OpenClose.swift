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
    
    public init(key: String, position: Int) {
        self._method = "GET"
        self._endpoint = "/openclose/\(key)/\(position)"
    }
    
    public convenience init(led: Led) {
        self.init(key: led.key, position: led.position)
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
}
