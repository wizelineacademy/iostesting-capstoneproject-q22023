//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import Foundation

enum FeedDataManagerError: Error {
    case badURL
    case networkingError(Error)
    case unknownError
    case decodingError(Error)
}

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void)
}

class FeedDataManager: FeedDataManagerProtocol {
    
    let baseURLString: String = "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json"
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
        guard let url = URL(string: baseURLString) else {
            completion(.failure(FeedDataManagerError.badURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        urlSession.dataTask(with: urlRequest) { (data, _, error) in
            if let error {
                completion(.failure(FeedDataManagerError.networkingError(error)))
                return
            }
            guard let data else {
                completion(.failure(FeedDataManagerError.unknownError))
                return
            }
            do {
                let viewModels = try JSONDecoder().decode([TweetCellViewModel].self, from: data)
                completion(.success(viewModels))
            } catch {
                completion(.failure(FeedDataManagerError.decodingError(error)))
            }
        }.resume()
    }
    
    
}
