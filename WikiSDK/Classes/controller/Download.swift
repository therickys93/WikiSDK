//
//  Download.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/16/18.
//

import Foundation

public class Download: Sendable {
    
    private var _endpoint: String
    private var _method: String
    
    public init() {
        self._method = "GET"
        self._endpoint = "/download"
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
