//
//  TweetCellViewModel.swift
//  MiniBootcamp
//
//  Created by Edgar Solis on 27/05/23.
//

import UIKit

struct TweetCellViewModel {
    let userName: String
    let profileName: String
    let profilePictureName: String
    let content: String
    
    var profilePicture: UIImage? {
        guard let image = UIImage(named: profilePictureName) else { return UIImage(named: "cat") }
        return image
    }
}


