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
    
    override  func tearDown() {
        super.tearDown()
        sut = nil
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
    
    func test_tableView_numberOfRows(){
        let tableView = sut.tableView
        
        XCTAssertEqual(1, tableView.numberOfRows(inSection: .zero))
    }
    
    func test_tableView_createsTweetCells() throws {
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is TweetCell)
    }
    
    func test_cellForRowAt(){
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssertNotNil(cell, "The cell should not be nil")
    }
    
    func test_binding_showLoaderWhenFetchingTweets() {
            let sut = FeedViewController()

            sut.loadViewIfNeeded()
            sut.observer.updateValue(with: .loading)

            let loader = sut.view.subviews.last
            XCTAssertTrue(loader is UIActivityIndicatorView)
        }
}
