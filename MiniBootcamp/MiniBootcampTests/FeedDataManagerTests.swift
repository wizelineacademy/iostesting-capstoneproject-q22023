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
        let sut = FeedDataManager()
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
                    XCTFail("Expected any error instead of: \(result)")
                }

                exp.fulfill()
            }

            wait(for: [exp], timeout: 1.0)
        }
}
