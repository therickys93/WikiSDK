//
//  WikiController.swift
//  Pods
//
//  Created by Riccardo Crippa on 10/14/18.
//

import Foundation

public class WikiController {
    
    private var _server: String
    
    public init(server: String) {
        self._server = server
    }
    
    public func execute(sendable: Sendable) -> String? {
        if sendable.method() == "GET" {
            return makeGetRequest(sendable: sendable)
        } else if sendable.method() == "POST" {
            return "POST"
        } else {
            return nil
        }
    }
    
    private func makeGetRequest(sendable: Sendable) -> String {
        let url = URL(string: "\(self._server)\(sendable.endpoint())")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        return ""
    }
    
}
