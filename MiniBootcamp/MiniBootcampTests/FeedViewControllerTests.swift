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
    
    func test_createATableView() throws {
        let sut = FeedViewController()
        
        sut.loadViewIfNeeded()
        
        let tableView = sut.tableView
        let viewContainsTableView = try XCTUnwrap(sut.view?.subviews.contains(tableView))
        XCTAssert(viewContainsTableView)
    }
    
    func test_setupTableView_delegates() {
        let sut = FeedViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssert(sut.tableView.delegate is FeedViewController)
        XCTAssert(sut.tableView.dataSource is FeedViewController)
    }
}
