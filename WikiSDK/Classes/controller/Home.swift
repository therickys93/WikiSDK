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
    
    public init() {
        self._method   = "GET"
        self._endpoint = "/"
    }
    
    public func endpoint() -> String {
        return self._endpoint
    }
    
    public func method() -> String {
        return self._method
    }
    
}
