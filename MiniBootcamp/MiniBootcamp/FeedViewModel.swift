//
//  FeedViewModel.swift
//  MiniBootcamp
//
//  Created by Josué Quiñones Rivera on 17/05/23.
//

import UIKit

class FeedViewModel {
    let title: String
    var backgroundColor: UIColor? = .white
    let tweetsURL = "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json"
    
    var tweets: [TweetCellViewModel] = []
    
    private let observer: Observer<FetchState> = Observer<FetchState>()
    private var dataManager: FeedDataManagerProtocol?
    
    var bind: ((FetchState) -> Void)? {
        didSet {
            observer.bind(bind)
        }
    }
    
    init(title: String = "TweetFeed", dataManager: FeedDataManagerProtocol? = FeedDataManager()) {
        self.title = title
        self.dataManager = dataManager
    }
    func fetchTimeline() {
        observer.updateValue(with: .loading)
        dataManager?.fetch(from: tweetsURL) { result in
            switch result {
            case .success(let tweetsReturned):
                self.tweets = tweetsReturned
                self.observer.updateValue(with: .success)
            case .failure:
                self.observer.updateValue(with: .failure)
            }
        }
    }
    
    func getErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "🥺", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(okAction)
        
        return alert
    }
}
