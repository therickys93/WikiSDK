//
//  Sendable.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/13/18.
//

import Foundation

public protocol Sendable {
    var endpoint: String { get }
    var method: String { get }
    var json: String? { get }
}
