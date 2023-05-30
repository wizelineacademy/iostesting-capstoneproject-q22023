//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol{}

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void)
}

class FeedDataManager: FeedDataManagerProtocol {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
        let urlTweet = URL(string: "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json")!
        let request = URLRequest(url: urlTweet)
        session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let unknownError = NSError(domain: "com.hariobudiharjo.unknownError", code: 0, userInfo: nil)
                    completion(.failure(unknownError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let tweets = try decoder.decode(TweetResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(tweets.mapToDomainModel()))
                    }
                } catch {
                    completion(.failure(error))
                }
            }.resume()
    }
}

extension TweetResponse {
    func mapToDomainModel() -> [TweetCellViewModel] {
        var model: [TweetCellViewModel] = []
        self.tweets?.forEach({ tweet in
            let tweetCellViewModel: TweetCellViewModel = TweetCellViewModel(userName: tweet.user?.name ?? "", profileName: tweet.user?.screenName ?? "", profilePictureName: tweet.user?.profileImageURL ?? "", content: tweet.text ?? "")
            model.append(tweetCellViewModel)
        })
        return model
    }
}


