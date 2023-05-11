//
//  FeedViewControllerTests.swift
//  MiniBootcampTests
//
//  Created by Fernando de la Rosa on 10/05/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedViewControllerTests: XCTestCase {
    
    func test_createFeedViewController() {
        let sut = FeedViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.title, "TweetFeed")
        XCTAssertEqual(sut.view.backgroundColor, UIColor.white)
    }
}
