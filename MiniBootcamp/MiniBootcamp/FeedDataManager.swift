//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import Foundation

enum TweetAPIError: Error {
    case noData
    case response
    case parsingData
}

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void)
}

class FeedDataManager: FeedDataManagerProtocol {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
        let url = URL(string: "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json")
        guard let url else { return }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            let decoder = JSONDecoder()
            guard let data else {
                completion(.failure(TweetAPIError.noData))
                return
            }
            
            do {
                let jsonData = try decoder.decode(TweetsResponse.self, from: data)
                let tweets = jsonData.tweets.map { $0.mapToViewModel() }
                DispatchQueue.main.async {
                    completion(.success(tweets))
                }
            } catch {
                completion(.failure(TweetAPIError.parsingData))
            }
        }
        task.resume()
    }
}
