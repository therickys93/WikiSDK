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
