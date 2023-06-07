//
//  Tweet.swift
//  MiniBootcamp
//
//  Created by Fernando de la Rosa on 07/06/23.
//

import Foundation

struct Response: Decodable {
    let tweets: [Tweet]
    
    func map() -> [TweetCellViewModel] {
        return tweets.map { tweet in
            TweetCellViewModel(
                userName: tweet.user.name,
                profileName: tweet.user.screen_name,
                profilePictureName: tweet.user.profile_image_url,
                content: tweet.text)
        }
    }
}

struct Tweet: Decodable {
    let text: String
    let user: User
}

struct User: Decodable {
    let name: String
    let screen_name: String
    let profile_image_url: String
}
