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
    
    public static func createStringFromLeds(_ leds: [Led]) -> String {
        var json = "["
        for led in leds {
            json += "{\"name\": \"\(led.name)\", \"key\": \"\(led.key)\", \"position\":\(led.position)},"
        }
        json.remove(at: json.index(before: json.endIndex))
        json += "]"
        return json
    }
    
    public static func parseLedsFromString(_ ledString: String) -> [Led] {
        var leds = [Led]()
        do {
            let json = try JSONSerialization.jsonObject(with: ledString.data(using: .utf8)!, options: .allowFragments) as? [[String : Any]]
            for i in 0..<json!.count {
                let name = json?[i]["name"] as? String
                let key  = json?[i]["key"] as? String
                let position = json?[i]["position"] as? Int
                let led = Led(name: name!, key: key!, position: position!)
                leds.append(led)
            }
        } catch {
            leds.removeAll()
        }
        return leds
    }
    
    public func upload(leds: [Led], completionHandler handler: @escaping (Bool) -> Void) {
        self.execute(sendable: Upload(leds: leds)) { response in
            if response.contains("true") {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    public func download(_ handler: @escaping ([Led]) -> Void) {
        self.execute(sendable: Download()) { response in
            let leds = WikiController.parseLedsFromString(response)
            handler(leds)
        }
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
        self.switchOff(key: led.key, position: led.position) { response in
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
        } else if sendable.method == "POST" {
            self.makePostRequest(sendable: sendable) { (response) in
                handler(response)
            }
        }
    }
    
    private func makeGetRequest(sendable: Sendable, completionHandler handler: @escaping (String) -> Void) {
        let url = URL(string: "\(self._server)\(sendable.endpoint)")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                handler("{'success': false}")
                return
            }
            handler(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    private func makePostRequest(sendable: Sendable, completionHandler handler: @escaping (String) -> Void) {
        let url = URL(string: "\(self._server)\(sendable.endpoint)")
        var request = URLRequest(url: url!)
        request.httpMethod = sendable.method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        print(sendable.json!)
        request.httpBody = sendable.json?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                handler("{'success': false}")
                return
            }
            let result = String(data: data, encoding: .utf8)
            handler(result!)
        }
        task.resume()
    }
    
}
