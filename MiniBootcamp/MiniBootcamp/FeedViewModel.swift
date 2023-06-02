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
    
    var tweets: [TweetCellViewModel] = []
    
    let observer: Observer<FetchState> = Observer<FetchState>()
    let dataManager: FeedDataManagerProtocol
    
    var bind: ((FetchState?) -> Void)? {
        didSet {
            observer.bind(bind)
        }
    }
    
    init(title: String = "TweetFeed", dataManager: FeedDataManagerProtocol = FeedDataManager()) {
        self.title = title
        self.dataManager = dataManager
    }
    func fetchTimeline() {
        dataManager.fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tweets):
                self.tweets = tweets
                self.observer.updateValue(with: .success)
            case .failure(_):
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
