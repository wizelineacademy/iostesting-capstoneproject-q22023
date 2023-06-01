//
//  TweetCellViewTests.swift
//  CapstoneTests
//
//  Created by Carlos Ceja.
//

import XCTest
@testable import Capstone

class TweetCellViewTests: XCTestCase {
    
    func test_createTweetCell() {
        let sut = TweetCellView()

        XCTAssertEqual(sut.backgroundColor, .systemBackground)
    }
    
    func test_configureCellInformation() {
        let sut = TweetCellView()
        let expectedViewModel = TweetCellViewModel(
            userName: "dummy-username",
            profileName: "dummy-profileName",
            profilePictureName: "cat",
            content: "dummy-content")

        sut.viewModel = expectedViewModel

        XCTAssertEqual(sut.usernameLabel.text, expectedViewModel.userName)
        XCTAssertEqual(sut.nameLabel.text, expectedViewModel.profileName)
        XCTAssertEqual(sut.contentLabel.text, expectedViewModel.content)
        XCTAssertEqual(sut.userImageView.image, expectedViewModel.profilePicture)
    }

}
