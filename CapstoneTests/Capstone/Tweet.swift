//
//  Tweet.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import Foundation

typealias Tweets = [Tweet]

// MARK: - Tweet
struct Tweet: Codable {

    let createdAt: String
    let idStr: String
    let text: String
    let user: User
    let favoriteCount: Int
    let retweetCount: Int

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case idStr = "id_str"
        case text
        case user
        case favoriteCount = "favorite_count"
        case retweetCount = "retweet_count"
    }

}

// MARK: - Timeline
struct Timeline: Codable {

    let tweets: [Tweet]

    enum CodingKeys: String, CodingKey {
        case tweets
    }

}
