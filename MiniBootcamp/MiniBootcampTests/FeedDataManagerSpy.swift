//
//  FeedDataManagerSpy.swift
//  MiniBootcampTests
//
//  Created by Fernando de la Rosa on 07/06/23.
//

import XCTest
@testable import MiniBootcamp

class FeedDataManagerSpy: FeedDataManagerProtocol {
    var result: Result<[TweetCellViewModel], FeedError> = .success([])
    var deadline: Double = 0.0
    var exp: XCTestExpectation?

    func fetch(from urlString: String, completion: @escaping (Result<[MiniBootcamp.TweetCellViewModel], FeedError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            completion(self.result)
            self.exp?.fulfill()
        }
    }
}
