//
//  FeedViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Marco Alonso Rodriguez on 28/05/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedViewModelTests: XCTestCase {
    
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
