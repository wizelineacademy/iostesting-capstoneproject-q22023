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
        
        let url = try? sut.validateURL(from: "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json")
        
        XCTAssertTrue(url != nil)
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
