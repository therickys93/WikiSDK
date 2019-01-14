//
//  Init.swift
//  Pods-WikiSDK_Example
//
//  Created by Riccardo Crippa on 1/14/19.
//

import Foundation

public class InitKey: Sendable {
    
    private var _endpoint: String
    private var _method: String
    
    public init(key: String) {
        self._endpoint = "/init/\(key)"
        self._method   = "GET"
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
    
}
