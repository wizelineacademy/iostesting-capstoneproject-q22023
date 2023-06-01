//
//  TweetCellViewModel.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import Foundation
import UIKit

struct TweetCellViewModel {
    let userName: String
    let profileName: String
    let profilePictureName: String
    let content: String

    var profilePicture: UIImage? {
        return UIImage(systemName: "person.crop.circle")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    }
}
