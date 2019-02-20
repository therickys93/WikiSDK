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
    
    func testEmptyLed() {
        let led = Led()
        XCTAssertEqual("", led.name)
        XCTAssertEqual("", led.key)
        XCTAssertEqual(-1, led.position)
    }
    
    func testHouseAddLed() {
        let house = House()
        XCTAssertEqual(0, house.led.count)
        _ = house.addLed(Led(name: "name", key: "key", position: 1))
        XCTAssertEqual(1, house.led.count)
    }
    
    func testHouseRemoveLed() {
        let house = House()
        XCTAssertEqual(0, house.led.count)
        _ = house.addLed(Led(name: "name", key: "key", position: 1))
        XCTAssertEqual(1, house.led.count)
        house.removeLedAt(0)
        XCTAssertEqual(0, house.led.count)
    }
    
    func testHouseRemoveLedByName() {
        let house = House()
        XCTAssertEqual(0, house.led.count)
        _ = house.addLed(Led(name: "name", key: "key", position: 1))
        XCTAssertEqual(1, house.led.count)
        house.removeLedByName("name")
        XCTAssertEqual(0, house.led.count)
    }
    
    func testHouseGetLedByName() {
        let house = House()
        _ = house.addLed(Led(name: "name", key: "key", position: 1))
        let led = house.getLedByName("name")
        XCTAssertEqual("name", led?.name)
        XCTAssertEqual("key", led?.key)
        XCTAssertEqual(1, led?.position)
    }
    
    func testHouseGetLedByPosition() {
        let house = House()
        _ = house.addLed(Led(name: "name", key: "key", position: 1))
        let led = house.getLedAtPosition(0)
        XCTAssertEqual("name", led.name)
        XCTAssertEqual("key", led.key)
        XCTAssertEqual(1, led.position)
    }
    
    func testHouseLedCount() {
        let house = House(leds: [])
        XCTAssertEqual(0, house.ledCount())
        _ = house.addLed(Led(name: "name", key: "key", position: 1))
        XCTAssertEqual(1, house.ledCount())
    }
    
    func testSensor() {
        let sensor = Sensor(name: "name", key: "key", position: 1)
        XCTAssertEqual("name", sensor.name)
        XCTAssertEqual("key", sensor.key)
        XCTAssertEqual(1, sensor.position)
    }
    
    func testEmptySensor() {
        let sensor = Sensor()
        XCTAssertEqual("", sensor.name)
        XCTAssertEqual("", sensor.key)
        XCTAssertEqual(-1, sensor.position)
    }
    
}
