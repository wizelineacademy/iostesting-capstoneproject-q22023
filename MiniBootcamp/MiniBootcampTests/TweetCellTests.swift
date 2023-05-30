//
//  TweetCellTests.swift
//  MiniBootcampTests
//
//  Created by Fernando de la Rosa on 17/05/23.
//

import XCTest
@testable import MiniBootcamp

final class TweetCellTests: XCTestCase {
    
    var sut: TweetCell!
    
    override func setUp() {
        super.setUp()
        sut = TweetCell()
    }
    
    func test_cellIsNotNil() {
        let sut = TweetCell()
        XCTAssertNotNil(sut)
    }
    
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
    
    
    func testuserImageView_initialConfiguration() {
        let defaultThumb = UIImage(named: "avatar")
        XCTAssertEqual(sut.userImageView.layer.cornerRadius, 25)
        XCTAssertTrue(sut.userImageView.clipsToBounds)
        XCTAssertEqual(sut.userImageView.image, defaultThumb)
    }
    
    func testNameLabel_initialConfiguration() {
        let font = UIFont.bold(withSize: 16)
        let textColor = UIColor.label
        
        XCTAssertEqual(sut.nameLabel.font, font)
        XCTAssertEqual(sut.nameLabel.numberOfLines, 1)
        XCTAssertEqual(sut.nameLabel.textColor, textColor)
    }
    
    func testusernameLabel_initialConfiguration() {
        let font = UIFont.bold(withSize: 13)
        let textColor = UIColor.systemGray2
        
        XCTAssertEqual(sut.usernameLabel.font, font)
        XCTAssertEqual(sut.usernameLabel.numberOfLines, 1)
        XCTAssertEqual(sut.usernameLabel.textColor, textColor)
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
}

