//
//  ControllerTests.swift
//  WikiSDK_Tests
//
//  Created by Riccardo Crippa on 1/31/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import WikiSDK

class ControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testHome() {
        let home = Home()
        XCTAssertEqual("/", home.endpoint)
        XCTAssertEqual(nil, home.json)
        XCTAssertEqual(nil, home.key)
        XCTAssertEqual(nil, home.led?.key)
        XCTAssertEqual(nil, home.led?.position)
        XCTAssertEqual(nil, home.led?.name)
        XCTAssertEqual("GET", home.method)
        XCTAssertEqual(nil, home.position)
        XCTAssertEqual("Home", home.type)
    }
    
    func testReset() {
        let reset = Reset(key: "key")
        XCTAssertEqual("/reset/key", reset.endpoint)
        XCTAssertEqual(nil, reset.json)
        XCTAssertEqual("key", reset.key)
        XCTAssertEqual(nil, reset.led?.key)
        XCTAssertEqual(nil, reset.led?.position)
        XCTAssertEqual(nil, reset.led?.name)
        XCTAssertEqual("GET", reset.method)
        XCTAssertEqual(nil, reset.position)
        XCTAssertEqual("Reset", reset.type)
    }
    
    func testStatus() {
        let status = Status(key: "key")
        XCTAssertEqual("/status/key", status.endpoint)
        XCTAssertEqual(nil, status.json)
        XCTAssertEqual("key", status.key)
        XCTAssertEqual(nil, status.led?.key)
        XCTAssertEqual(nil, status.led?.position)
        XCTAssertEqual(nil, status.led?.name)
        XCTAssertEqual("GET", status.method)
        XCTAssertEqual(nil, status.position)
        XCTAssertEqual("Stato", status.type)
    }
    
    func testDownload() {
        let download = Download()
        XCTAssertEqual("/download", download.endpoint)
        XCTAssertEqual(nil, download.json)
        XCTAssertEqual(nil, download.key)
        XCTAssertEqual(nil, download.led?.key)
        XCTAssertEqual(nil, download.led?.position)
        XCTAssertEqual(nil, download.led?.name)
        XCTAssertEqual("GET", download.method)
        XCTAssertEqual(nil, download.position)
        XCTAssertEqual("Scarica", download.type)
    }
    
    func testUpload() {
        let upload = Upload(leds: [])
        XCTAssertEqual("/upload", upload.endpoint)
        XCTAssertEqual("[]", upload.json)
        XCTAssertEqual(nil, upload.key)
        XCTAssertEqual(nil, upload.led?.key)
        XCTAssertEqual(nil, upload.led?.position)
        XCTAssertEqual(nil, upload.led?.name)
        XCTAssertEqual("POST", upload.method)
        XCTAssertEqual(nil, upload.position)
        XCTAssertEqual("Carica", upload.type)
    }
    
    func testInitKey() {
        let initKey = InitKey(key: "key")
        XCTAssertEqual("/init/key", initKey.endpoint)
        XCTAssertEqual(nil, initKey.json)
        XCTAssertEqual("key", initKey.key)
        XCTAssertEqual(nil, initKey.led?.key)
        XCTAssertEqual(nil, initKey.led?.position)
        XCTAssertEqual(nil, initKey.led?.name)
        XCTAssertEqual("GET", initKey.method)
        XCTAssertEqual(nil, initKey.position)
        XCTAssertEqual("Init", initKey.type)
    }
    
    func testOn() {
        let on = On(key: "key", position: 1)
        XCTAssertEqual("/on/key/1", on.endpoint)
        XCTAssertEqual(nil, on.json)
        XCTAssertEqual("key", on.key)
        XCTAssertEqual(nil, on.led?.key)
        XCTAssertEqual(nil, on.led?.position)
        XCTAssertEqual(nil, on.led?.name)
        XCTAssertEqual("GET", on.method)
        XCTAssertEqual(1, on.position)
        XCTAssertEqual("Accendi", on.type)
    }
    
    func testOnWithLed() {
        let on = On(led: Led(name: "pippo", key: "key", position: 1))
        XCTAssertEqual("/on/key/1", on.endpoint)
        XCTAssertEqual(nil, on.json)
        XCTAssertEqual("key", on.key)
        XCTAssertEqual("key", on.led?.key)
        XCTAssertEqual(1, on.led?.position)
        XCTAssertEqual("pippo", on.led?.name)
        XCTAssertEqual("GET", on.method)
        XCTAssertEqual(1, on.position)
        XCTAssertEqual("Accendi", on.type)
    }
    
    func testOff() {
        let off = Off(key: "key", position: 1)
        XCTAssertEqual("/off/key/1", off.endpoint)
        XCTAssertEqual(nil, off.json)
        XCTAssertEqual("key", off.key)
        XCTAssertEqual(nil, off.led?.key)
        XCTAssertEqual(nil, off.led?.position)
        XCTAssertEqual(nil, off.led?.name)
        XCTAssertEqual("GET", off.method)
        XCTAssertEqual(1, off.position)
        XCTAssertEqual("Spegni", off.type)
    }
    
    func testOffWithLed() {
        let off = Off(led: Led(name: "pippo", key: "key", position: 1))
        XCTAssertEqual("/off/key/1", off.endpoint)
        XCTAssertEqual(nil, off.json)
        XCTAssertEqual("key", off.key)
        XCTAssertEqual("key", off.led?.key)
        XCTAssertEqual(1, off.led?.position)
        XCTAssertEqual("pippo", off.led?.name)
        XCTAssertEqual("GET", off.method)
        XCTAssertEqual(1, off.position)
        XCTAssertEqual("Spegni", off.type)
    }

    func testOpenClose() {
        let openclose = OpenClose(key: "key", position: 1)
        XCTAssertEqual("/openclose/key/1", openclose.endpoint)
        XCTAssertEqual(nil, openclose.json)
        XCTAssertEqual("key", openclose.key)
        XCTAssertEqual(nil, openclose.led?.key)
        XCTAssertEqual(nil, openclose.led?.position)
        XCTAssertEqual(nil, openclose.led?.name)
        XCTAssertEqual("GET", openclose.method)
        XCTAssertEqual(1, openclose.position)
        XCTAssertEqual("Apri/Chiudi", openclose.type)
    }
    
    func testOpenCloseWithLed() {
        let openclose = OpenClose(led: Led(name: "pippo", key: "key", position: 1))
        XCTAssertEqual("/openclose/key/1", openclose.endpoint)
        XCTAssertEqual(nil, openclose.json)
        XCTAssertEqual("key", openclose.key)
        XCTAssertEqual("key", openclose.led?.key)
        XCTAssertEqual(1, openclose.led?.position)
        XCTAssertEqual("pippo", openclose.led?.name)
        XCTAssertEqual("GET", openclose.method)
        XCTAssertEqual(1, openclose.position)
        XCTAssertEqual("Apri/Chiudi", openclose.type)
    }
    
    func testStatusWithKeyPosition() {
        let status = Status(key: "key", position: 1)
        XCTAssertEqual("/status/key/1", status.endpoint)
        XCTAssertEqual(nil, status.json)
        XCTAssertEqual("key", status.key)
        XCTAssertEqual(nil, status.led?.key)
        XCTAssertEqual(nil, status.led?.position)
        XCTAssertEqual(nil, status.led?.name)
        XCTAssertEqual("GET", status.method)
        XCTAssertEqual(1, status.position)
        XCTAssertEqual("Stato", status.type)
    }

    func testStatusWithLed() {
        let status = Status(led: Led(name: "pippo", key: "key", position: 1))
        XCTAssertEqual("/status/key/1", status.endpoint)
        XCTAssertEqual(nil, status.json)
        XCTAssertEqual("key", status.key)
        XCTAssertEqual("key", status.led?.key)
        XCTAssertEqual(1, status.led?.position)
        XCTAssertEqual("pippo", status.led?.name)
        XCTAssertEqual("GET", status.method)
        XCTAssertEqual(1, status.position)
        XCTAssertEqual("Stato", status.type)
    }
    
    func testSensors() {
        let sensors = Sensors(key: "key", position: 1)
        XCTAssertEqual("/sensors/key/1", sensors.endpoint)
        XCTAssertEqual(nil, sensors.json)
        XCTAssertEqual("key", sensors.key)
        XCTAssertEqual(nil, sensors.led?.key)
        XCTAssertEqual(nil, sensors.led?.position)
        XCTAssertEqual(nil, sensors.led?.name)
        XCTAssertEqual("GET", sensors.method)
        XCTAssertEqual(1, sensors.position)
        XCTAssertEqual("Sensors", sensors.type)
        XCTAssertEqual(nil, sensors.sensor?.key)
        XCTAssertEqual(nil, sensors.sensor?.name)
        XCTAssertEqual(nil, sensors.sensor?.position)
    }
    
    func testSensorsWithSensor() {
        let sensors = Sensors(sensor: Sensor(name: "name", key: "key", position: 2))
        XCTAssertEqual("/sensors/key/2", sensors.endpoint)
        XCTAssertEqual(nil, sensors.json)
        XCTAssertEqual("key", sensors.key)
        XCTAssertEqual(nil, sensors.led?.key)
        XCTAssertEqual(nil, sensors.led?.position)
        XCTAssertEqual(nil, sensors.led?.name)
        XCTAssertEqual("GET", sensors.method)
        XCTAssertEqual(2, sensors.position)
        XCTAssertEqual("Sensors", sensors.type)
        XCTAssertEqual("name", sensors.sensor?.name)
        XCTAssertEqual("key", sensors.sensor?.key)
        XCTAssertEqual(2, sensors.sensor?.position)
    }

}
