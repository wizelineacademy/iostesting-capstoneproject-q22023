//
//  TweetParserTests.swift
//  MiniBootcampTests
//
//  Created by Pedro Cruz Caballero on 29/05/23.
//

import XCTest
@testable import MiniBootcamp

final class TweetParserTests: XCTestCase {

    func test_parseTweet_CorrectResponse() throws {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweet_mock", ofType: "json") else { fatalError("Couldn't find json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let sut = try JSONDecoder().decode(Tweet.self, from: data)
        
        XCTAssertEqual(sut.idStr, "id")
        XCTAssertEqual(sut.text, "This is an example")
        XCTAssertEqual(sut.favoriteCount, 100)
        XCTAssertEqual(sut.retweetCount, 10)
    }
    

}
