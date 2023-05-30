//
//  FeedDataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Edgar Solis on 29/05/23.
//

import Foundation

import XCTest
@testable import MiniBootcamp

final class FeedDataManagerTests: XCTestCase {
    
    func test_fetchingData_returnsAnyError() {
        
        let mockFeedDataManager = MockFeedDataManager()
        mockFeedDataManager.mockError = NSError(domain: "", code: 0)
        
        let expectation = XCTestExpectation(description: "Fetch completion called")
        
        mockFeedDataManager.fetch { result in
            switch result {
            case .success:
                XCTFail("Fetch should fail with AnyError error")
            case .failure(let error):
                XCTAssertFalse(error is NetworkError, "Error should not be of type NetworkError")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_dataManager_willNotFetchData_fromBadURL() {

        let mockFeedDataManager = MockFeedDataManager()
        mockFeedDataManager.mockError = NetworkError.invalidURL
        
        let expectation = XCTestExpectation(description: "Fetch completion called")
        
        mockFeedDataManager.fetch { result in
            switch result {
            case .success:
                XCTFail("Fetch should fail with invalidURL error")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    func test_dataManager_returnsBadJsonError() {

        let mockFeedDataManager = MockFeedDataManager()
        mockFeedDataManager.mockError = NetworkError.emptyResponseData
        
        let expectation = XCTestExpectation(description: "Fetch completion called")
        
        mockFeedDataManager.fetch { result in
            switch result {
            case .success:
                XCTFail("Fetch should fail with invalidURL error")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.emptyResponseData)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    func test_dataManager_decodingFailed() {

        let mockFeedDataManager = MockFeedDataManager()
        mockFeedDataManager.mockError = NetworkError.decodingFailed
        
        let expectation = XCTestExpectation(description: "Fetch completion called")
        
        mockFeedDataManager.fetch { result in
            switch result {
            case .success:
                XCTFail("Fetch should fail with invalidURL error")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.decodingFailed)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    func test_dataManager_FetchSuccess() {
        let mockFeedDataManager = MockFeedDataManager()
        mockFeedDataManager.mockData = Data()
        mockFeedDataManager.mockResponse = HTTPURLResponse(url: URL(string: NetworkConstants.tweetsURL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = XCTestExpectation(description: "Fetch completion called")
        
        mockFeedDataManager.fetch { result in
            switch result {
            case .success(let tweetCellViewModels):
                XCTAssertFalse(tweetCellViewModels.isEmpty)
            case .failure(let error):
                XCTFail("Fetch should not fail: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Private helper methods
    private class MockFeedDataManager: FeedDataManager {
        var mockData: Data?
        var mockResponse: URLResponse?
        var mockError: Error?
        
        override func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
            let task = session.dataTask(with: URL(string: "NetworkConstants.tweetsURL")!) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = self.mockError {
                        completion(.failure(error))
                    } else {
                        completion(.success([self.anyTweet()]))
                    }
                }
            }
            task.resume()
        }
        private func anyTweet() -> TweetCellViewModel {
            TweetCellViewModel(userName: "any-name", profileName: "any-profile", profilePictureName: "cat", content: "any-content")
        }
    }
}
