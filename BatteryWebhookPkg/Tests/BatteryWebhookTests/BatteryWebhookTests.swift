import XCTest
@testable import BatteryWebhook

final class BatteryWebhookTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    func testVersion() throws {
        XCTAssertEqual(BatteryWebhookUtilities.getVersion(), 2.0, "Version was not 2.0")
    }
}
