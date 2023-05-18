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
    
    func test_tableView_numberOfRows() {
        let sut = FeedViewController()
        
        sut.loadViewIfNeeded()
        
        let tableView = sut.tableView
        XCTAssertEqual(1, tableView.numberOfRows(inSection: .zero))
    }
    
    func test_tableView_createsTweetCells() throws {
        let sut = FeedViewController()
        
        sut.loadViewIfNeeded()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is TweetCell)
    }
    
    func test_binding_showLoaderWhenFetchingTweets() {
        let sut = FeedViewController()
        
        sut.loadViewIfNeeded()
        sut.observer.updateValue(with: .loading)
        
        let loader = sut.view.subviews.last
        XCTAssertTrue(loader is UIActivityIndicatorView)
    }
    
    func test_binding_hideLoaderOnFailedFetch() {
        // Given
        let sut = FeedViewController()
        
        // When
        sut.loadViewIfNeeded()
        sut.observer.updateValue(with: .loading)
        sut.observer.updateValue(with: .failure)
        
        // Then
        let loader = sut.view.subviews.last
        XCTAssertFalse(loader is UIActivityIndicatorView)
    }
    
    func test_binding_hideLoaderOnSuccessFetch() {
        // Given
        let sut = FeedViewController()
        
        // When
        sut.loadViewIfNeeded()
        sut.observer.updateValue(with: .loading)
        sut.observer.updateValue(with: .success)
        
        // Then
        let loader = sut.view.subviews.last
        XCTAssertFalse(loader is UIActivityIndicatorView)
    }
}
