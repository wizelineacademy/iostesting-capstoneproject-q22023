//
//  MockDataTask.swift
//  MiniBootcampTests
//
//  Created by Hario Budiharjo on 27/05/23.
//

import Foundation

class MockDataTask: URLSessionDataTask {
    private let closure: () -> ()
    
    init(closure: @escaping () -> ()) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
