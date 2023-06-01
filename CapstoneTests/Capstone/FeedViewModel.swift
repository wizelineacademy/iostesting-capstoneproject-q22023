//
//  FeedViewModel.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import UIKit

class FeedViewModel {

    static let serviceUrl = "https://gist.githubusercontent.com/ferdelarosa-wz/0c73ab5311c845fb7dfac4b62ab6c652/raw/6a39cffe68d87f1613f222372c62bd4e89ad06fa/tweets.json"

    let title: String
    var backgroundColor: UIColor? = .white

    var tweets: [TweetCellViewModel] = []

    let observer: Observer<FetchState> = Observer<FetchState>()
    let dataManager: FeedDataManagerProtocol

    var bind: ((FetchState?) -> Void)? {
        didSet {
            observer.bind(bind)
        }
    }

    init(title: String = "TweetFeed", dataManager: FeedDataManagerProtocol = FeedDataManager(serviceUrl: FeedViewModel.serviceUrl)) {
        self.title = title
        self.dataManager = dataManager
    }

    func fetchTimeline() {
        dataManager.fetch { result in
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
