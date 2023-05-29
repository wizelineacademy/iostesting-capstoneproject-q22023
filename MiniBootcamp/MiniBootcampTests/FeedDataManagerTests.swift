//
//  FeedDataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Marco Alonso Rodriguez on 29/05/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedDataManagerTests: XCTestCase {

    func test_geTweets(){
        let sut = FeedDataManager()
        
        
        sut.fetch { tweets in
            switch tweets {
            case .success(let listOfTweets):
                XCTAssertNotNil(listOfTweets)
                
            case .failure:
                print("Error")
            }
        }
    }
    
    func test_TweetModelMapper_returnTweetCellViewModel(){
        
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: "TweetResponseModelMock", withExtension: "json") else {
            XCTFail("No se encontró el archivo JSON")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            
            let listOfTweets = decodeDataToTweet(data: jsonData)
            
            let TweetCellViewModelMock = TweetCellViewModel(userName: "Wizeboot", profileName: "user", profilePictureName: "url", content: "url")
            
            for tweet in listOfTweets {
                XCTAssertNotNil(TweetModelMapper.mapDataModelToTweetCellViewModel(dataModel: tweet))
            }
            
        } catch {
            XCTFail("Error al cargar el archivo JSON: \(error.localizedDescription)")
            return
        }
        
    }
    
    private func decodeDataToTweet(data: Data) -> [Tweet] {
        var list: [Tweet] = []
        do {
            let response = try JSONDecoder().decode(TweetResponseModel.self, from: data)
            let listOfTweets = response.tweets
            list = listOfTweets
            
        } catch {
            print("Debug: error \(error.localizedDescription)")
            XCTFail("Error decoding data")
        }
        
        return list
    }

}
