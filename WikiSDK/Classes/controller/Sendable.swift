//
//  Sendable.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/13/18.
//

import Foundation

public protocol Sendable {
    func endpoint() -> String
    func method() -> String
}
