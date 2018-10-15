//
//  Reset.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/14/18.
//

import Foundation

public class Reset: Sendable {
    
    private var _endpoint: String
    private var _method: String
    
    public init(key: String) {
        self._endpoint = "/reset/\(key)"
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
    
}
