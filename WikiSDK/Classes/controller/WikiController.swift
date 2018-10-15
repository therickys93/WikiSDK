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
    
    public func execute(sendable: Sendable, completionHandler handler: @escaping (String) -> Void){
        if sendable.method() == "GET" {
            self.makeGetRequest(sendable: sendable) { (response) in
                handler(response)
            }
        }
    }
    
    private func makeGetRequest(sendable: Sendable, completionHandler handler: @escaping (String) -> Void) {
        let url = URL(string: "\(self._server)\(sendable.endpoint())")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            handler(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
