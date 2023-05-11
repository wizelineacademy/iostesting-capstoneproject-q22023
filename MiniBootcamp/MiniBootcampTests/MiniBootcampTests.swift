//
//  MiniBootcampTests.swift
//  MiniBootcampTests
//
//  Created by Marco Alonso Rodriguez on 10/05/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedViewControllerTests: XCTestCase {
    
    var sut: FeedViewController!
    
    override  func setUp() {
        super.setUp()
        
        sut = FeedViewController()
        
        sut.loadViewIfNeeded()
    }
    
    func test_createFeedViewController(){
        
        
        XCTAssertEqual(sut.title, "TweetFeed")
        XCTAssertEqual(sut.view.backgroundColor, UIColor.white)
    }
    
    func test_createATableView() throws {
        
        let tableView = sut.tableView
        let viewConstaintsTableView = try XCTUnwrap(sut.view.subviews.contains(tableView))
        XCTAssert(viewConstaintsTableView)
    }
    
    func test_setupTableView_delegates() {
        
        XCTAssert(sut.tableView.delegate is FeedViewController)
        XCTAssert(sut.tableView.dataSource is FeedViewController)
    }
    
    
    
    func test_cellForRowAt(){
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssertNotNil(cell, "The cell should not be nil")
    }

    override  func tearDown() {
        super.tearDown()
        sut = nil
    }
}
