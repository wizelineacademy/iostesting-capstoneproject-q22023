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
        let exp = expectation(description: "Fetching data...")

        sut.fetch { result in
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
}
