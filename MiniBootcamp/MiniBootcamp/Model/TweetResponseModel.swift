//
//  TweetResponseModel.swift
//  MiniBootcamp
//
//  Created by Marco Alonso Rodriguez on 28/05/23.
//

import Foundation

struct TweetResponseModel: Codable {
    let tweets: [Tweet]
}

// MARK: - Tweet
struct Tweet: Codable {
    let createdAt: CreatedAt
    let idStr: IDStr
    let text: Text
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

enum CreatedAt: String, Codable {
    case creation = "creation"
}

enum IDStr: String, Codable {
    case id = "id"
}

enum Text: String, Codable {
    case thisIsAnExample = "This is an example"
}

// MARK: - User
struct User: Codable {
    let name: Name
    let screenName: ScreenName
    let description: Description
    let location: Location
    let followersCount: Int
    let createdAt: CreatedAt
    let profileBackgroundColor: ProfileBackgroundColor
    let profileImageURL, profileBackgroundImageURL: ProfileImageURL

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

enum Description: String, Codable {
    case description = "description"
}

enum Location: String, Codable {
    case location = "location"
}

enum Name: String, Codable {
    case wizeboot = "Wizeboot"
}

enum ProfileBackgroundColor: String, Codable {
    case red = "red"
}

enum ProfileImageURL: String, Codable {
    case url = "url"
}

enum ScreenName: String, Codable {
    case wizeboot = "@wizeboot"
}
