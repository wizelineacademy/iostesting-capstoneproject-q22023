//
//  TweetModel.swift
//  MiniBootcamp
//
//  Created by Rafael Salazar on 29/05/23.
//

import Foundation

struct TweetModel: Decodable {
    let user: User
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case user
        case content = "text"
    }
    
    struct User: Decodable {
        let name: String
        let userName: String
        let profilePictureName: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case userName = "screen_name"
            case profilePictureName = "profile_image_url"
        }
    }
    
    func toViewModel() -> TweetCellViewModel {
        TweetCellViewModel(userName: user.userName, profileName: user.name, profilePictureName: user.profilePictureName, content: content)
    }
}

struct TweetAPIResult: Decodable {
    let tweets: [TweetModel]
}
