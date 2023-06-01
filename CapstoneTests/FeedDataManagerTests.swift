//
//  FeedDataManagerTests.swift
//  CapstoneTests
//
//  Created by Carlos Ceja.
//

import XCTest
@testable import Capstone

class FeedDataManagerTests: XCTestCase {
    
    func test_willNotFetchData_fromBadURL() {
        let dataManager = FeedDataManager(serviceUrl: "badurl")
        let exp = expectation(description: "will not fetch data from bad url")
        
        dataManager.fetch { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error as NSError):
                XCTAssertEqual(error, NSError(domain: "", code: 0))
            }
            exp.fulfill()
        }
        
        // When
        XCTAssertNotNil(dataManager)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_dataManager_willParseTweetFromValidData() {
        let expectedViewModel = TweetCellViewModel(
            userName: "dummy-username",
            profileName: "dummy-profileName",
            profilePictureName: "cat",
            content: "dummy-content")

        let sut = FeedViewController()
        let dataManager = FeedDataManagerSpy()
        let dummyViewModel = FeedViewModel(title: "expectedTitle", dataManager: dataManager)
        sut.viewModel = dummyViewModel
        dataManager.result = .success([anyTweet()])
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.viewModel.tweets)
        XCTAssertEqual(sut.viewModel.tweets.count, 1)
    
    }

    
    // MARK: - Private helper methods

    private func anyTweet() -> TweetCellViewModel {
        TweetCellViewModel(
            userName: "dummy-username",
            profileName: "dummy-profileName",
            profilePictureName: "cat",
            content: "dummy-content")
    }
    
    private class FeedDataManagerSpy: FeedDataManagerProtocol {
        var result: Result<[TweetCellViewModel], Error> = .success([])
        
        func fetch(completion: (Result<[TweetCellViewModel], Error>) -> Void) {
            completion(result)
        }
    }
    

}

