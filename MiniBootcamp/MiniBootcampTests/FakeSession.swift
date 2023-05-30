//
//  FakeSession.swift
//  MiniBootcampTests
//
//  Created by Hario Budiharjo on 27/05/23.
//

import Foundation
@testable import MiniBootcamp

class FakeSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        MockDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}
