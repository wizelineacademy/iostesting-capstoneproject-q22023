//
//  DataManagerTests.swift
//  MiniBootcampTests
//
//  Created by Pedro Cruz Caballero on 30/05/23.
//

import XCTest
@testable import MiniBootcamp

final class DataManagerTests: XCTestCase {
    

    func testAPIRequest_SucecesfulResponse() {
        
        let sut = FeedDataManager()
        
        let expectation = expectation(description: "tweettimeline expectation")
        var response = false
        
        // when
        sut.fetch { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(response)
    }
    
    
    func testAPIRequest_WrongResponse() {
        
        let sut = FeedDataManager()
        sut.endpointURL = "wrong_endpoint_string_example"
        
        let expectation = expectation(description: "tweettimeline expectation")
        var error = false
        
        // when
        sut.fetch { result in
            switch result {
                case .success(_ ):
                    error = false
                case .failure:
                    error = true
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(error)
    }

}
