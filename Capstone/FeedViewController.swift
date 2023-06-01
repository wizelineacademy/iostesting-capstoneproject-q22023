//
//  FeedViewController.swift
//  Capstone
//
//  Created by Carlos Ceja.
//

import UIKit

enum FetchState {
    case loading
    case failure
    case success
}

class FeedViewController: UIViewController {

    private(set) lazy var tableView: UITableView = {
        let tableView =  UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private(set) lazy var loader: UIActivityIndicatorView = {
        UIActivityIndicatorView(frame: view.bounds)
    }()

    var viewModel: FeedViewModel = FeedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = viewModel.backgroundColor
        setupTableView()
        binding()
        fetchTimeline()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(TweetCellView.self, forCellReuseIdentifier: TweetCellView.identifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.frame = view.bounds
    }

    private func binding() {
        viewModel.bind = { [weak self] state in
            guard let state = state, let strongSelf = self else { return }
            switch state {
            case .loading:
                strongSelf.view.addSubview(strongSelf.loader)
            case .failure:
                strongSelf.loader.removeFromSuperview()
                strongSelf.present(strongSelf.viewModel.getErrorAlert(), animated: true)
            case .success:
                strongSelf.loader.removeFromSuperview()
                strongSelf.tableView.reloadData()
            }
        }
    }

    private func fetchTimeline() {
        viewModel.fetchTimeline()
    }

}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetCellView.identifier) as? TweetCellView else { return UITableViewCell() }
        cell.viewModel = viewModel.tweets[indexPath.row]
        
        return cell
    }

}
