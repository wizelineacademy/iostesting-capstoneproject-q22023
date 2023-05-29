//
//  TweetResponse.swift
//  MiniBootcamp
//
//  Created by Hario Budiharjo on 29/05/23.
//

import Foundation

// MARK: - TweetResponse
struct TweetResponse: Codable {
    var tweets: [Tweet]?
    
    // MARK: - Tweet
    struct Tweet: Codable {
        var createdAt: String?
        var idStr: String?
        var text: String?
        var user: User?
        var favoriteCount, retweetCount: Int?

        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case idStr = "id_str"
            case text, user
            case favoriteCount = "favorite_count"
            case retweetCount = "retweet_count"
        }

        // MARK: - User
        struct User: Codable {
            var name: String?
            var screenName: String?
            var description: String?
            var location: String?
            var followersCount: Int?
            var createdAt: String?
            var profileBackgroundColor: String?
            var profileImageURL, profileBackgroundImageURL: String?

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
    }
}
