//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import UIKit

enum APIError: Error {
    case badURL
    case badJSON
}

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void)
}

class FeedDataManager: FeedDataManagerProtocol {
    
    static let url = "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json"
    
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
        do {
            let url = try validateURL(from: FeedDataManager.url)
            URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                guard let self = self, let data = data else { return }
                do {
                    let tweets = try self.decodeTweetCells(from: data)
                    completion(.success(tweets))
                }
                catch(let error) {
                    completion(.failure(error))
                }
            }.resume()
        } catch(let error) {
            completion(.failure(error))
        }
    }
    
    func validateURL(from string: String) throws -> URL {
        if let url = URL(string: string), UIApplication.shared.canOpenURL(url) {
            return url
        } else {
            throw APIError.badURL
        }
    }
    
    func decodeTweetCells(from data: Data) throws -> [TweetCellViewModel] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(TweetAPIResult.self, from: data)
            return result.tweets.map({ $0.toViewModel() })
        } catch {
            throw APIError.badJSON
        }
    }
    
    
}
