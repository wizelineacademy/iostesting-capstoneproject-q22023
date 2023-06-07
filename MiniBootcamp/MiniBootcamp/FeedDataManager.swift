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

protocol URLSessionProtocol {
    func task(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
}

protocol FeedDataManagerProtocol {
    func fetch(from urlString: String, completion: @escaping (Result<[TweetCellViewModel], FeedError>) -> Void)
}

final class FeedDataManager: FeedDataManagerProtocol {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetch(from urlString: String, completion: @escaping (Result<[TweetCellViewModel], FeedError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        let _ = session.task(with: request) { data, _, _ in
            if let _ = data {
                completion(.success([]))
            } else {
                completion(.failure(.badResponse))
            }
        }
    }
}

extension URLSession: URLSessionProtocol {
    func task(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        dataTask(with: request, completionHandler: completion)
    }
}
