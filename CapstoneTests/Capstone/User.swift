//
//  User.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import Foundation


// MARK: - User
struct User: Codable {

    let name: String
    let screenName: String
    let description: String
    let location: String
    let followersCount: Int
    let createdAt: String
    let profileBackgroundColor: String
    let profileImageUrl: String
    let profileBackgroundImageUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case screenName = "screen_name"
        case description
        case location
        case followersCount = "followers_count"
        case createdAt = "created_at"
        case profileBackgroundColor = "profile_background_color"
        case profileImageUrl = "profile_image_url"
        case profileBackgroundImageUrl = "profile_background_image_url"
    }

}
