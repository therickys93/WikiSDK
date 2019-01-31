import XCTest
import WikiSDK

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLed() {
        let led = Led(name: "name", key: "key", position: 1)
        XCTAssertEqual("name", led.name)
        XCTAssertEqual("key", led.key)
        XCTAssertEqual(1, led.position)
    }
    
}
