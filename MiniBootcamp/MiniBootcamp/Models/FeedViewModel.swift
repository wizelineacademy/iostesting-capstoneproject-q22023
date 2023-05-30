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
        
        self.observer.updateValue(with: .loading)
        
        dataManager.fetch { result in
            switch result {
            case .success(let tweetsReturned):
                self.tweets = self.parseTweetCellsData(tweetsReturned)
                self.observer.updateValue(with: .success)
            case .failure:
                self.observer.updateValue(with: .failure)
            }
        }
    }
    
    func parseTweetCellsData(_ tweets: [Tweet]) -> [TweetCellViewModel] {
        
        var tweetCells : [TweetCellViewModel] = []
        for tweet in tweets {
            print("Tweet: \(tweet.idStr)" )
            var tweetCell = TweetCellViewModel(userName: tweet.user.name,
                                               profileName: tweet.user.screenName,
                                               profilePictureName: "cat",
                                               content: tweet.text)
            
            tweetCells.append(tweetCell)
        }
        
        print("parseTweetCellsData:\(tweetCells.count)")
        return tweetCells
    }
    
    
    func getErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "🥺", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(okAction)
        
        return alert
    }
}
