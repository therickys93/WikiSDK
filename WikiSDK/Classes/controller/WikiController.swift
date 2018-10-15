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
    
    public func reset(key: String, completionHandler handler: @escaping (Bool) -> Void) {
        self.execute(sendable: Reset(key: key)) { response in
            if response.contains("true") {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    public func status(key: String, completionHandler handler: @escaping (String) -> Void) {
        self.execute(sendable: Status(key: key)) { response in
            handler(response)
        }
    }
    
    public func openClose(led: Led, completionHandler handler: @escaping (Bool) -> Void) {
        self.switchOn(key: led.key, position: led.position) { response in
            handler(response)
        }
    }
    
    public func openClose(key: String, position: Int, completionHandler handler: @escaping (Bool) -> Void) {
        self.execute(sendable: OpenClose(key: key, position: position)) { response in
            if response.contains("true") {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    public func switchOff(led: Led, completionHandler handler: @escaping (Bool) -> Void) {
        self.switchOn(key: led.key, position: led.position) { response in
            handler(response)
        }
    }
    
    public func switchOff(key: String, position: Int, completionHandler handler: @escaping (Bool) -> Void) {
        self.execute(sendable: Off(key: key, position: position)) { response in
            if response.contains("true") {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    public func switchOn(led: Led, completionHandler handler: @escaping (Bool) -> Void) {
        self.switchOn(key: led.key, position: led.position) { response in
            handler(response)
        }
    }
    
    public func switchOn(key: String, position: Int, completionHandler handler: @escaping (Bool) -> Void) {
        self.execute(sendable: On(key: key, position: position)) { response in
            if response.contains("true") {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    public func execute(sendable: Sendable, completionHandler handler: @escaping (String) -> Void){
        if sendable.method == "GET" {
            self.makeGetRequest(sendable: sendable) { (response) in
                handler(response)
            }
        }
    }
    
    private func makeGetRequest(sendable: Sendable, completionHandler handler: @escaping (String) -> Void) {
        let url = URL(string: "\(self._server)\(sendable.endpoint)")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            handler(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
