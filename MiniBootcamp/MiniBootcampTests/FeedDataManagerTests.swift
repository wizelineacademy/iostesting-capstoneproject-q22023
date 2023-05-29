//
//  FeedDataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Marco Alonso Rodriguez on 29/05/23.
//

import XCTest
@testable import MiniBootcamp

final class FeedDataManagerTests: XCTestCase {
    
    var sut: FeedDataManager!
    private var session: FakeSession!
    
    override func setUp() {
        super.setUp()
        session = FakeSession()
        sut = FeedDataManager(session: session)
    }
    
    override func tearDown() {
         super.tearDown()
         sut = nil
         session = nil
     }
    
    private class FakeSession: URLSession {
        var data: Data?
        var error: Error?
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            MockDataTask {
                completionHandler(self.data, nil, self.error)
            }
        }
    }
    
    private class MockDataTask: URLSessionDataTask {
          private let closure: () -> ()

          init(closure: @escaping () -> ()) {
              self.closure = closure
          }

          override func resume() {
              closure()
          }
      }
    
    func test_NetworkResponse() {
        let expectation = expectation(description: "Getting data tweets")
        var response: Bool = false
        
        sut.fetch { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(response)
    }
    
    func test_ResponseWithError() {
        let expectation = expectation(description: "Error founded")
        var expectedError: NetworkError?
        session.error = NetworkError.badURL

        sut.fetch { result in
            switch result {
            case .failure(let error):
                expectedError = error as? NetworkError
                expectation.fulfill()
            default:
                break
            }
        }

        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(expectedError)
    }

    
    func test_ResponseWithNoData() throws {
        let expectation = expectation(description: "No data")
        var expectedError: NetworkError?

        sut.fetch { result in
            switch result {
            case .failure(let error):
                expectedError = error as? NetworkError
                expectation.fulfill()
            default:
                break
            }
        }

        wait(for: [expectation], timeout: 3.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .badRequest)
    }
    
    func test_ResponseWithParsingError() throws {
        let expectation = expectation(description: "Parsing error found")
        var expectedError: NetworkError?
        session.data = Data()


        sut.fetch { result in
            switch result {
            case .failure(let error):
                expectedError = error as? NetworkError
                expectation.fulfill()
            default:
                break
            }
        }

        wait(for: [expectation], timeout: 3.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .decodingError)
    }
    
    func test_mapDataModelToTweetCellViewModel(){
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: "TweetResponseModelMock", withExtension: "json") else {
            XCTFail("No se encontró el archivo JSON")
            return
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            
            let tweets = try JSONDecoder().decode(TweetResponseModel.self, from: jsonData)
            let tweet = tweets.tweets.first
            let tweetCellViewModelExp =  TweetModelMapper.mapDataModelToTweetCellViewModel(dataModel: tweet!)
            
            XCTAssertNotNil(tweetCellViewModelExp)
        } catch {
            XCTFail("Error al cargar el archivo JSON: \(error.localizedDescription)")
            return
        }
        
        
    }
    
    func test_uifontExtensions(){
        let fontDemoBold = UIFont.bold(withSize: 20)
        let fontDemoNormal = UIFont.normal(withSize: 20)
        
        XCTAssertNotNil(fontDemoBold)
        XCTAssertNotNil(fontDemoNormal)
    }
}
