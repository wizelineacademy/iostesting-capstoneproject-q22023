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

enum TweetAPIError: Error {
    case noData
    case response
    case parsingData
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

// MARK: - TweetsResponse
struct TweetsResponse: Codable {
    let tweets: [Tweet]
}

// MARK: - Tweet
struct Tweet: Codable {
    let user: User
    let createdAt, idStr, text: String
    let favoriteCount, retweetCount: Int

    enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case idStr = "id_str"
            case text, user
            case favoriteCount = "favorite_count"
            case retweetCount = "retweet_count"
        }

  func mapToViewModel() -> TweetCellViewModel {
    TweetCellViewModel(
      userName: user.name,
      profileName: user.screenName,
      profilePictureName: user.profileImageURL,
      content: text
    )
  }
}

// MARK: - User
struct User: Codable {
    let followersCount: Int
    let name, screenName, description, location, createdAt: String
    let profileBackgroundColor, profileImageURL, profileBackgroundImageURL: String

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
