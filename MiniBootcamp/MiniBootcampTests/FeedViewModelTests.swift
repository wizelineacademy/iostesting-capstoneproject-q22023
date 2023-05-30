//
//  FeedViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Josué Quiñones Rivera on 25/05/23.
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
    func test_getErrorAlert_createsErrorAlert() {
        let viewModel = FeedViewModel()
        
        let alertController = viewModel.getErrorAlert()
        
        XCTAssertEqual(alertController.title, "Error", "Alert title should be 'Error'")
        XCTAssertEqual(alertController.message, "🥺", "Alert message should be '🥺'")
        XCTAssertEqual(alertController.preferredStyle, .alert, "Alert style should be UIAlertController.Style.alert")
        
        XCTAssertEqual(alertController.actions.count, 1, "Alert should have one action")
        
        guard let okAction = alertController.actions.first else {
            XCTFail("Alert should have an OK action")
            return
        }
        
        XCTAssertEqual(okAction.title, "Ok", "OK action title should be 'Ok'")
        XCTAssertEqual(okAction.style, .cancel, "OK action style should be UIAlertAction.Style.cancel")
    }
}
