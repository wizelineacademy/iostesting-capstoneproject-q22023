//
//  Observer.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 17/05/23.
//

import Foundation

protocol Observable {
    associatedtype ObservedObject
    typealias Subscriber = (ObservedObject) -> ()
    var value: ObservedObject! { get }
    var subscriber: Subscriber? { get }
    
    func updateValue(with newValue: ObservedObject)
    func bind(_ subscriber: Subscriber?)
}

class Observer<T>: Observable {
    typealias ObservedObject = T

    private(set) var subscriber: Subscriber?
    
    private(set) var value: ObservedObject! {
        didSet {
            subscriber?(value)
        }
    }

    func updateValue(with newValue: ObservedObject) {
        self.value = newValue
    }

    func bind(_ subscriber: Subscriber?) {
        self.subscriber = subscriber
    }
}
