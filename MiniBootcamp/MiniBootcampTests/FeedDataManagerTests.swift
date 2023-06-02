//
//  FeedDataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Rafael Salazar on 28/05/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedDataManagerTests: XCTestCase {

    func test_dataManager_throwError_fromBadURL() {
        let sut = FeedDataManager()
        
        do {
            _ = try sut.validateURL(from: "lorem-ipsum")
        } catch(let error) {
            XCTAssertEqual(error as! APIError, APIError.badURL)
        }
    }
    
    func test_dataManager_getURL_fromGoodURL() {
        let sut = FeedDataManager()
        
        let url = try? sut.validateURL(from: FeedDataManager.url)
        
        XCTAssertTrue(url != nil)
    }
    
    func test_requestHasError() {
        let sut = FeedDataManager()
        
        let error = NSError(domain: "", code: 1)
        
        XCTAssertFalse(sut.isValidResponse(error: error, response: nil))
    }
    
    func test_requestHasNoError() {
        let sut = FeedDataManager()
        
        guard let url = try? sut.validateURL(from: FeedDataManager.url) else { return }
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        XCTAssertTrue(sut.isValidResponse(error: nil, response: response))
    }
    
    func test_dataManager_throwError_fromBadJSON() {
        let jsonString = "{\"created_at\": \"creation\", \"id_str\": \"id\", \"text\": \"This is an example\", \"user\": { \"name\": \"Wizeboot\", \"screen_name\": \"@wizeboot\", \"description\": \"description\", \"location\": \"location\", \"followers_count\": 100, \"created_at\": \"creation\", \"profile_background_color\": \"red\", \"profile_image_url\": \"url\", \"profile_background_image_url\": \"url\"}, \"favorite_count\": 100, \"retweet_count\": 10}"
        let data = jsonString.data(using: .utf8)!
        
        let sut = FeedDataManager()
        
        do {
            _ = try sut.decodeTweetCells(from: data)
        } catch(let error) {
            XCTAssertEqual(error as! APIError, APIError.badJSON)
        }
    }
    
    func test_dataManager_getArray_fromGoodJSON() {
        let jsonString = "{\"tweets\": [{\"created_at\": \"creation\", \"id_str\": \"id\", \"text\": \"This is an example\", \"user\": { \"name\": \"Wizeboot\", \"screen_name\": \"@wizeboot\", \"description\": \"description\", \"location\": \"location\", \"followers_count\": 100, \"created_at\": \"creation\", \"profile_background_color\": \"red\", \"profile_image_url\": \"url\", \"profile_background_image_url\": \"url\"}, \"favorite_count\": 100, \"retweet_count\": 10}]}"
        let data = jsonString.data(using: .utf8)!
        
        let sut = FeedDataManager()
        
        let tweets = try? sut.decodeTweetCells(from: data)
        
        XCTAssertTrue(tweets != nil)
    }
    
    func test_dataManager_fetch() {
        let sut = FeedDataManager()
        
        let exp = expectation(description: "Wait for fetch")
        sut.fetch { result in
            switch result {
            case .success(let tweets):
                XCTAssertFalse(tweets.isEmpty)
            case .failure(_):
                XCTFail()
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
    }
}
