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
    
    func test_createEmptyTableView_showNoCells() {
        let sut = FeedViewController()
        
        sut.loadViewIfNeeded()
        
        let tableView = sut.tableView
        XCTAssertEqual(0, tableView.numberOfRows(inSection: .zero))
    }
    
    func test_tableView_createsTweetCells() throws {
        let sut = FeedViewController()
        let dataManager = FeedDataManagerSpy()
        let dummyViewModel = FeedViewModel(title: "expectedTitle", dataManager: dataManager)
        let exp = expectation(description: "Wait for completion")
        sut.viewModel = dummyViewModel
        dataManager.result = .success([anyTweet()])
        dataManager.exp = exp
        
        sut.loadViewIfNeeded()
        wait(for: [exp], timeout: 1.0)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssert(cell is TweetCell)
    }
    
    func test_binding_showLoaderWhenFetchingTweets() {
        let sut = FeedViewController()
        let dataManager = FeedDataManagerSpy()
        let dummyViewModel = FeedViewModel(title: "expectedTitle", dataManager: dataManager)
        sut.viewModel = dummyViewModel
        dataManager.deadline = 1.0
        
        sut.loadViewIfNeeded()
        
        let loader = sut.view.subviews.last
        XCTAssertTrue(loader is UIActivityIndicatorView)
    }
    
    func test_binding_hideLoaderOnFailedFetch() {
        // Given
        let sut = FeedViewController()
        let dataManager = FeedDataManagerSpy()
        let viewModelMock = FeedViewModelMock(title: "expectedTitle", dataManager: dataManager)
        let exp = expectation(description: "Wait for completion")
        sut.viewModel = viewModelMock
        dataManager.result = .failure(.badResponse)
        dataManager.exp = exp
        
        // When
        sut.loadViewIfNeeded()
        wait(for: [exp], timeout: 1.0)
        
        // Then
        let loader = sut.view.subviews.last
        XCTAssertFalse(loader is UIActivityIndicatorView)
    }
    
    func test_binding_hideLoaderOnSuccessFetch() {
        // Given
        let sut = FeedViewController()
        let dataManager = FeedDataManagerSpy()
        let viewModelMock = FeedViewModelMock(title: "expectedTitle", dataManager: dataManager)
        let exp = expectation(description: "Wait for completion")
        sut.viewModel = viewModelMock
        dataManager.result = .success([anyTweet()])
        dataManager.exp = exp
        
        // When
        sut.loadViewIfNeeded()
        wait(for: [exp], timeout: 1.0)
        
        // Then
        let loader = sut.view.subviews.last
        XCTAssertFalse(loader is UIActivityIndicatorView)
    }
    
    func test_fetchTimeline_showAlertOnFailedFetch() {
        let sut = FeedViewController()
        let dataManager = FeedDataManagerSpy()
        let viewModelMock = FeedViewModelMock(title: "expectedTitle", dataManager: dataManager)
        let exp = expectation(description: "Wait for completion")
        sut.viewModel = viewModelMock
        dataManager.result = .failure(.badResponse)
        dataManager.exp = exp
        
        sut.loadViewIfNeeded()
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(viewModelMock.alertRequested)
    }
    
    func test_fetchTimeline_reloadDataOnSuccessfulFetch() {
        let sut = FeedViewController()
        let dataManager = FeedDataManagerSpy()
        let dummyViewModel = FeedViewModel(title: "expectedTitle", dataManager: dataManager)
        sut.viewModel = dummyViewModel
        let exp1 = expectation(description: "Wait for completion")
        let exp2 = expectation(description: "Wait for completion")
        
        sut.loadViewIfNeeded()
        dataManager.exp = exp1
        
        wait(for: [exp1], timeout: 1.0)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        dataManager.exp = exp2
        dataManager.result = .success([anyTweet()])
        sut.viewModel.fetchTimeline()
        
        wait(for: [exp2], timeout: 1.0)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    // MARK: - Private helper methods
    private func anyTweet() -> TweetCellViewModel {
        TweetCellViewModel(userName: "any-name", profileName: "any-profile", profilePictureName: "cat", content: "any-content")
    }
    
    private class FeedViewModelMock: FeedViewModel {
        var alertRequested: Bool = false
        
        override func getErrorAlert() -> UIAlertController {
            alertRequested = true
            return UIAlertController()
        }
    }
}
