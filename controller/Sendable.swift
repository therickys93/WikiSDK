//
//  Sendable.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/13/18.
//

import Foundation

public protocol Sendable {
    public func endpoint() -> String
    public func method() -> String
}
