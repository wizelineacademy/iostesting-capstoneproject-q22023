//
//  TweetTests.swift
//  MiniBootcampTests
//
//  Created by Ikechukwu Onuorah on 29/05/2023.
//

import XCTest
@testable import MiniBootcamp

final class TweetTests: XCTestCase {
  func test_mapToViewModel() {
    let sut = Tweet(
      user: User(
        followersCount: 20,
        name: "test",
        screenName: "dummy-name",
        description: "dummy-description",
        location: "dummy-location",
        createdAt: "dummy-creat",
        profileBackgroundColor: "dummy-color",
        profileImageURL: "dummy-url",
        profileBackgroundImageURL: "dummy-image-url"
      ),
      createdAt: "dummy-create-at",
      idStr: "dummy-id",
      text: "dummy-text",
      favoriteCount: 3,
      retweetCount: 5
    )

    let expectedViewModel = sut.mapToViewModel()

    XCTAssertEqual(expectedViewModel.userName, "test")
    XCTAssertEqual(expectedViewModel.profileName, "dummy-name")
    XCTAssertEqual(expectedViewModel.profilePictureName, "dummy-url")
    XCTAssertEqual(expectedViewModel.content, "dummy-text")
  }
}
