//
//  TweetModelTests.swift
//  MiniBootcampTests
//
//  Created by Rafael Salazar on 29/05/23.
//

import XCTest
@testable import MiniBootcamp

final class TweetModelTests: XCTest {
    
    func test_model_mapToViewModel() {
        let user = TweetModel.User(name: "any-name", userName: "any-username", profilePictureName: "any-picture")
        let sut = TweetModel(user: user, content: "any-content")
        
        let viewModel = sut.toViewModel()
        
        XCTAssertEqual(viewModel.userName, sut.user.userName)
        XCTAssertEqual(viewModel.profileName, sut.user.name)
        XCTAssertEqual(viewModel.profilePictureName, sut.user.profilePictureName)
        XCTAssertEqual(viewModel.content, sut.content)
    }
}
