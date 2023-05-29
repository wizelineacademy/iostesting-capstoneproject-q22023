//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Marco Alonso Rodriguez on 28/05/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badURL
}

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void)
}


class FeedDataManager: FeedDataManagerProtocol {
//    func fetch(completion: (Result<[TweetCellViewModel], Error>) -> Void) {
//        completion(.failure(NSError(domain: "", code: 0)))
//    }
    
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
        var listTweetCellViewModel : [TweetCellViewModel] = []
        
        guard let url = URL(string: "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.badRequest))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TweetResponseModel.self, from: data)
                let listOfTweets = response.tweets
                
                for tweet in listOfTweets {
                    listTweetCellViewModel.append(TweetModelMapper.mapDataModelToTweetCellViewModel(dataModel: tweet))
                }
                
                DispatchQueue.main.async {
                    completion(.success(listTweetCellViewModel))
                }
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
        
    }
}
