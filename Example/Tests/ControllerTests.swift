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
}
