//
//  FeedViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedViewModelTests: XCTestCase {
    
    func test_setNotNilBindingToObserver_establishConnection() {
        // Given
        let sut = FeedViewModel(dataManager: nil)
        let exp = expectation(description: "Wait for bind")
        
        sut.bind = { _ in
            // Then
            exp.fulfill()
        }
        
        // When
        sut.fetchTimeline()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_setNilBindingToObserver_breaksConnection() {
        let sut = FeedViewModel()
        
        sut.fetchTimeline()
        XCTAssertNil(sut.bind)
    }
    
    func test_getErrorAlert_createsErrorAlert() {
        let sut = FeedViewModel()
        
        let alert = sut.getErrorAlert()
        
        XCTAssertEqual(alert.title, "Error")
        XCTAssertEqual(alert.message, "🥺")
        XCTAssertEqual(alert.actions.first?.title, "Ok")
        XCTAssertEqual(alert.actions.first?.style, .cancel)
    }
}
