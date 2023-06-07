//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import Foundation

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void)
}

class FeedDataManager: FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
        completion(.failure(NSError(domain: "", code: 0)))
    }
}
