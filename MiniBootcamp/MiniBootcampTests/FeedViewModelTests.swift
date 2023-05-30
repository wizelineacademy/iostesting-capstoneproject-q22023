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
    
    
    func test_parseTweets_CellSData() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweets_mock", ofType: "json") else { fatalError("Couldn't find json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let tweetJSON = try JSONDecoder().decode(Tweets.self, from: data)
        
        let sut = FeedViewModel()
        let arr = sut.parseTweetCellsData(tweetJSON.tweets)
        XCTAssertGreaterThan(arr.count, 0)
        
    }
    
}
