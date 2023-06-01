//
//  TweetModelTests.swift
//  MiniBootcampTests
//
//  Created by Chioma Amanda Mmegwa  on 29/05/2023.
//

import XCTest
@testable import MiniBootcamp

final class TweetModelTests: XCTestCase {
    func test_mapToViewModel() {
      let sut = Tweet(
        user: User(
          followersCount: 20,
          name: "test",
          screenName: "screenName",
          description: "description",
          location: "location",
          createdAt: "createdAt",
          profileBackgroundColor: "backgroundColor",
          profileImageURL: "imageUrl",
          profileBackgroundImageURL: "backgroundImageUrl"
        ),
        createdAt: "createdAt",
        idStr: "id",
        text: "text",
        favoriteCount: 5,
        retweetCount: 10
      )

      let expectedViewModel = sut.mapToViewModel()

      XCTAssertEqual(expectedViewModel.userName, "test")
      XCTAssertEqual(expectedViewModel.profileName, "screenName")
      XCTAssertEqual(expectedViewModel.profilePictureName, "imageUrl")
      XCTAssertEqual(expectedViewModel.content, "text")
    }
}
