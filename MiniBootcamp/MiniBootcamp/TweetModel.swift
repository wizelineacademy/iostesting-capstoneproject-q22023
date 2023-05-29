//
//  TweetModel.swift
//  MiniBootcamp
//
//  Created by Chioma Amanda Mmegwa  on 29/05/2023.
//

import UIKit

struct TweetCellViewModel {
    let userName: String
    let profileName: String
    let profilePictureName: String
    let content: String
    
    var profilePicture: UIImage? {
        return UIImage(named: profilePictureName)
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

