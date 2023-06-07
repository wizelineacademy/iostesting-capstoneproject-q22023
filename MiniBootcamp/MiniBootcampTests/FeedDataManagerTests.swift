//
//  FeedDataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Fernando de la Rosa on 07/06/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedDataManagerTests: XCTestCase {
    
    func test_fetchingData_returnsAnyError() {
        let session = URLSessionSpy()
        session.error = NSError(domain: "any-error", code: 0)
        let sut = FeedDataManager(session: session)
        let anyURL = "https://gist.githubusercontent.com"
        let exp = expectation(description: "Fetching data...")
        
        sut.fetch(from: anyURL) { result in
            switch result {
            case .failure:
                break
            default:
                XCTFail("Expected any error instead of: \(result)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_dataManager_willNotFetchData_fromBadURL() {
        let sut = FeedDataManager()
        let urlString = "any corrupt url"
        let expectedError = FeedError.badURL
        let exp = expectation(description: "Fetching data...")
        
        sut.fetch(from: urlString) { result in
            switch result {
            case let .failure(error):
                XCTAssertEqual(expectedError, error)
            default:
                XCTFail("Expected bad url error instead of: \(result)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_dataManager_returnsBadJsonError_onAnyData() {
        let session = URLSessionSpy()
        session.data = Data()
        let sut = FeedDataManager(session: session)
        
        let urlString = "any-valid-url"
        let exp = expectation(description: "Fetching data...")
        
        sut.fetch(from: urlString) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                XCTAssertEqual(error, .badJSON)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_dataManager_willParseTweetFromValidData() {
        let session = URLSessionSpy()
        session.data = fakeResponse()
        let sut = FeedDataManager(session: session)
        
        let urlString = "any-valid-url"
        let exp = expectation(description: "Fetching data...")
        
        sut.fetch(from: urlString) { result in
            switch result {
            case let .success(tweets):
                XCTAssertEqual(tweets.count, 1)
                XCTAssertEqual(tweets.first?.profileName, "@wizeboot")
            default:
                XCTFail("Expected tweets instead of: \(result)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func fakeResponse() -> Data {
        return """
            {
                "tweets": [
                    {
                        "text": "This is an example",
                        "user": {
                            "name": "Wizeboot",
                            "screen_name": "@wizeboot",
                            "profile_image_url": "url"
                        }
                    }
                ]
            }
            """.data(using: .utf8)!
    }
}

final class URLSessionSpy: URLSessionProtocol {
    var data: Data?
    var error: Error?
    
    func task(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        
        completion(data, nil, error)
        
        return nil
    }
}
