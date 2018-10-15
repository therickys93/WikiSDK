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
    
    public func endpoint() -> String {
        return self._endpoint
    }
    
    public func method() -> String {
        return self._method
    }
    
    
}