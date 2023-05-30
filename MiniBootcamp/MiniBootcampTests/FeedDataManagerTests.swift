//
//  FeedDataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Hario Budiharjo on 27/05/23.
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
        var expectedError: Error?
        session.error = NSError(domain: "", code: 0)
        
        sut.fetch { result in
            switch result {
            case .failure(let error):
                expectedError = error
                expectation.fulfill()
            default:
                break
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(expectedError)
    }
    
    func test_ResponseWithData() {
        let expectation = expectation(description: "Error founded")
        var expectedData: [TweetCellViewModel]?
        session.data = DummyData().dummyJson()
        
        sut.fetch { result in
            switch result {
            case .success(let success):
                expectedData = success
                expectation.fulfill()
            default:
                break
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(expectedData)
    }
    
    func test_ResponseWithDataWrong() {
        let expectation = expectation(description: "Error founded")
        var expectedError: Error?
        session.data = DummyData().dummyJsonWrong()
        
        sut.fetch { result in
            switch result {
            case .failure(let error):
                expectedError = error
                expectation.fulfill()
            default:
                break
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(expectedError)
    }
    
    func test_uifontExtensions(){
        let fontDemoBold = UIFont.bold(withSize: 20)
        let fontDemoNormal = UIFont.normal(withSize: 20)
        
        XCTAssertNotNil(fontDemoBold)
        XCTAssertNotNil(fontDemoNormal)
    }
}
