//
//  TweetCellTests.swift
//  MiniBootcampTests
//
//  Created by Fernando de la Rosa on 17/05/23.
//

import XCTest
@testable import MiniBootcamp

final class TweetCellTests: XCTestCase {
    func test_setupCell_whenSettingViewModel() {
        let sut = TweetCell()
        
        sut.viewModel = TweetCellViewModel(
            userName: "dummy-username",
            profileName: "dummy-profileName",
            profilePictureName: "cat",
            content: "dummy-content")
        
        XCTAssertEqual(sut.backgroundColor, UIColor.systemBackground)
    }
    
    func test_showInformationOnCell() {
        let sut = TweetCell()
        let expectedViewModel = TweetCellViewModel(
            userName: "dummy-username",
            profileName: "dummy-profileName",
            profilePictureName: "cat",
            content: "dummy-content")
        
        sut.viewModel = expectedViewModel
        
        XCTAssertEqual(sut.contentLabel.text, expectedViewModel.content)
        XCTAssertEqual(sut.nameLabel.text, expectedViewModel.profileName)
        XCTAssertEqual(sut.usernameLabel.text, expectedViewModel.userName)
        XCTAssertEqual(sut.userImageView.image, expectedViewModel.profilePicture)
    }
}

