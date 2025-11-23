import UIKit
import Combine
import XCTest

class CombineTests: XCTestCase {
    
    func test_sample_test() {
        let expectation = XCTestExpectation(description: "Received value")
        let publisher = Just("Hello World")
        
        _ = publisher.sink(receiveValue: { value in
            XCTAssertEqual(value, "Hello World")
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
}

CombineTests.defaultTestSuite.run()
