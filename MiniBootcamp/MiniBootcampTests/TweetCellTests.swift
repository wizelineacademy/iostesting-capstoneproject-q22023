//
//  TweetCellTests.swift
//  MiniBootcampTests
//
//  Created by Marco Alonso Rodriguez on 17/05/23.
//

import XCTest
@testable import MiniBootcamp

final class TweetCellTests: XCTestCase {
    
    func test_createTweetCell() {
        let sut = TweetCell()
        
        XCTAssertEqual(sut.backgroundColor, .systemBackground)
    }
    
    func test_configureCellInformation() {
            let sut = TweetCell()
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
