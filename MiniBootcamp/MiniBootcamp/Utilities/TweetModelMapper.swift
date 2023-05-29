//
//  TweetModelMapper.swift
//  MiniBootcamp
//
//  Created by Marco Alonso Rodriguez on 28/05/23.
//

import Foundation

class TweetModelMapper {
    static func mapDataModelToTweetCellViewModel(dataModel: Tweet) -> TweetCellViewModel {
        
        let userName = dataModel.user.name
        let profileName = dataModel.user.screenName
        let profilePictureName = dataModel.user.profileImageURL
        let content = dataModel.text
        
        return TweetCellViewModel(userName: userName.rawValue,
                                  profileName: profileName.rawValue,
                                  profilePictureName: profilePictureName.rawValue,
                                  content: content.rawValue)
    }
}

