//
//  FeedDataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Ikechukwu Onuorah on 29/05/2023.
//

import XCTest
@testable import MiniBootcamp

class FeedDataManagerTests: XCTestCase {
  var sut: FeedDataManager!
  private var session: FakeSession!

  override func setUp() {
      super.setUp()
      session = FakeSession()
      sut = FeedDataManager(session: session)
  }

  func testNetworkResponse() {
      let expectation = expectation(description: "tweet expectation")
      var response = false

      sut.fetch { result in
          response = true
          expectation.fulfill()
      }
      wait(for: [expectation], timeout: 3.0)
      XCTAssertTrue(response)
  }

  func testResponseWithError() {
      let expectation = expectation(description: "tweet expectation")
      var expectedError: TweetAPIError?
      session.error = TweetAPIError.response

      sut.fetch { result in
          switch result {
          case .failure(let error):
              expectedError = error as? TweetAPIError
              expectation.fulfill()
          default:
              break
          }
      }

      wait(for: [expectation], timeout: 3.0)
      XCTAssertNotNil(expectedError)
  }

  func testResponseWithNoData() throws {
      let expectation = expectation(description: "tweet expectation")
      var expectedError: TweetAPIError?

      sut.fetch { result in
          switch result {
          case .failure(let error):
              expectedError = error as? TweetAPIError
              expectation.fulfill()
          default:
              break
          }
      }

      wait(for: [expectation], timeout: 3.0)
      let unwrappedError = try XCTUnwrap(expectedError)
      XCTAssertEqual(unwrappedError, .noData)
  }

  func testResponseWithParsingError() throws {
      let expectation = expectation(description: "tweet expectation")
      var expectedError: TweetAPIError?
      session.data = Data()


      sut.fetch { result in
          switch result {
          case .failure(let error):
              expectedError = error as? TweetAPIError
              expectation.fulfill()
          default:
              break
          }
      }

      wait(for: [expectation], timeout: 3.0)
      let unwrappedError = try XCTUnwrap(expectedError)
      XCTAssertEqual(unwrappedError, .parsingData)
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

  override func tearDown() {
      super.tearDown()
      sut = nil
      session = nil
  }
}
