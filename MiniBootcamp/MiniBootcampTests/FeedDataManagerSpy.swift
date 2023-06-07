//
//  FeedDataManagerSpy.swift
//  MiniBootcampTests
//
//  Created by Fernando de la Rosa on 07/06/23.
//

import XCTest
@testable import MiniBootcamp

class FeedDataManagerSpy: FeedDataManagerProtocol {
    var result: Result<[TweetCellViewModel], Error> = .success([])
    var deadline: Double = 0.0
    var exp: XCTestExpectation?

    func fetch(completion: @escaping (Result<[MiniBootcamp.TweetCellViewModel], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            completion(self.result)
            self.exp?.fulfill()
        }
    }
}
