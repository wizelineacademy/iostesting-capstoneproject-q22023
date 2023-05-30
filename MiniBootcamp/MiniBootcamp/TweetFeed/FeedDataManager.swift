//
//  FeedDataManager.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 25/05/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case emptyResponseData
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
        guard let url = URL(string: NetworkConstants.tweetsURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.emptyResponseData))
                    return
                }
                
                do {
                    // Parse the JSON response into a Codable structure
                    let decoder = JSONDecoder()
                    let tweetFeedResponse = try decoder.decode(TweetFeedResponse.self, from: data)
                    
                    // Map the tweets to TweetCellViewModel objects
                    let tweetCellViewModels = tweetFeedResponse.tweets.map { tweet -> TweetCellViewModel in
                        return TweetCellViewModel(userName: tweet.user.screenName,
                                                  profileName: tweet.user.name,
                                                  profilePictureName: tweet.user.profileImageURL,
                                                  content: tweet.text)
                    }
                    completion(.success(tweetCellViewModels))
                } catch {
                    completion(.failure(NetworkError.decodingFailed))
                }
            }
        }
        task.resume()
    }
}

// MARK: - TweetFeed
struct TweetFeedResponse: Codable {
    let tweets: [Tweet]
}

// MARK: - Tweet
struct Tweet: Codable {
    let createdAt, idStr, text: String
    let user: User
    let favoriteCount, retweetCount: Int

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case idStr = "id_str"
        case text, user
        case favoriteCount = "favorite_count"
        case retweetCount = "retweet_count"
    }
}

// MARK: - User
struct User: Codable {
    let name, screenName, description, location: String
    let followersCount: Int
    let createdAt, profileBackgroundColor, profileImageURL, profileBackgroundImageURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case screenName = "screen_name"
        case description, location
        case followersCount = "followers_count"
        case createdAt = "created_at"
        case profileBackgroundColor = "profile_background_color"
        case profileImageURL = "profile_image_url"
        case profileBackgroundImageURL = "profile_background_image_url"
    }
}
