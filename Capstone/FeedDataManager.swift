//
//  FeedDataManager.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import Foundation

protocol FeedDataManagerProtocol {
    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void)
}

class FeedDataManager: FeedDataManagerProtocol {

    private var serviceUrl: String

    init(serviceUrl: String) {
        self.serviceUrl = serviceUrl
    }

    func fetch(completion: @escaping (Result<[TweetCellViewModel], Error>) -> Void) {
        HttpRequestHelper.GET(url: serviceUrl) { tweets -> Void in
            DispatchQueue.main.async {
                if let tweets = tweets {
                    let tweetsViewModel = tweets.map { TweetCellViewModel(userName: $0.user.name, profileName: $0.user.screenName, profilePictureName: $0.user.profileImageUrl, content: $0.text) }
                    completion(.success(tweetsViewModel))
                }
                else {
                    completion(.failure(NSError(domain: "", code: 0)))
                }
            }
        }
    }
 
}
