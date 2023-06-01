//
//  FeedViewModelTests.swift
//  CapstoneTests
//
//  Created by Carlos Ceja.
//

import XCTest
@testable import Capstone

class FeedViewModelTests: XCTestCase {
    
    func test_setNotNilBindingToObserver_stablishConnection() {
        // Given
        let sut = FeedViewModel()
        let exp = expectation(description: "Wait for bind")
        
        sut.observer.bind { state in
            // Then
            XCTAssertEqual(state, .loading)
            exp.fulfill()
        }
        
        // When
        sut.observer.updateValue(with: .loading)
        XCTAssertNotNil(sut.observer)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_setNilBindingToObserver_breaksConnection() {
        let sut = FeedViewModel()
        
        sut.observer.updateValue(with: .loading)
        XCTAssertNil(sut.bind)
    }
}
