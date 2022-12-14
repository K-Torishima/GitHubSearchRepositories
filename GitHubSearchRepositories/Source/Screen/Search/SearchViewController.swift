//
//  SearchViewController.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {
    
    private var viewModel: SearchViewModel = SearchViewModel()
    private var cancelables = Set<AnyCancellable>()
    
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCell(SearchTableViewCell.self)
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        bind()
    }
    
    private func initialize() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.set(router: self)
    }
    
    private func bind() {
        // indicator制御
        viewModel.$progressState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .none:
                    self?.indicator.isHidden = true
                    self?.indicator.stopAnimating()
                case .fetch:
                    self?.indicator.isHidden = false
                    self?.indicator.startAnimating()
                }
            }.store(in: &cancelables)
        // datasource反映
        viewModel.$datasource
            .receive(on: DispatchQueue.main)
            .sink { [weak self] datasource in
                self?.tableView.isHidden = datasource.count < 0
                self?.tableView.reloadData()
            }.store(in: &cancelables)
    }
}

extension SearchViewController: UISearchBarDelegate {
    // インクリメンタルサーチ
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text,
              !searchText.isEmpty else {
            viewModel.reset()
            return
        }
        viewModel.debounceApply(searchText: searchText)
    }
    
    // エンター押す時に叩く
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              !searchText.isEmpty else {
            viewModel.reset()
            return
        }
        viewModel.throttleApply(searchText: searchText)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeue(indexPath: indexPath)
        cell.apply(data: viewModel.datasource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: SearchRouting {}
