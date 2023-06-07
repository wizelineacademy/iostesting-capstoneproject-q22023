//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import Foundation

enum FeedError: Error {
    case badURL
    case badResponse
}

protocol FeedDataManagerProtocol {
    func fetch(from urlString: String, completion: @escaping (Result<[TweetCellViewModel], FeedError>) -> Void)
}

final class FeedDataManager: FeedDataManagerProtocol {
    func fetch(from urlString: String, completion: @escaping (Result<[TweetCellViewModel], FeedError>) -> Void) {
        guard let _ = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }

        completion(.failure(.badResponse))
    }
}
