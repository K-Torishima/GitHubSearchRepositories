//
//  SearchViewModel.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel {
    
    enum ProgressState {
        case none
        case fetch
    }
    
    // Publisher
    @Published private (set) var progressState: ProgressState = .none
    @Published private (set) var datasource: [Repositories] = []
    
    private var page: Int = 1
    private let perPage: Int = 20
    private let debounce = DispatchQueue.global().debounce(delay: .milliseconds(500))
    private let throttle = DispatchQueue.global().throttle(delay: .milliseconds(1000))
    
    private let searchRepository: SearchRepository
    private weak var router: SearchRouting?
    
    init(searchRepository: SearchRepository = SearchRepositoryImpl()) {
        self.searchRepository = searchRepository
    }
    
    func set(router: SearchRouting) {
        self.router = router
    }
        
    func debounceApply(searchText: String) {
        reset()
        progressState = .fetch
        debounce { [unowned self] in
            fetchRepositories(query: searchText, page: page, perPage: perPage)
        }
    }
    
    func throttleApply(searchText: String) {
        reset()
        progressState = .fetch
        throttle { [unowned self] in
            fetchRepositories(query: searchText, page: page, perPage: perPage)
        }
    }
    
    func didSelectRowAt(_ row: Int) {
        let data = datasource[row]
        router?.navigateDetail(data: data)
    }
    
    private func fetchRepositories(query: String, page: Int, perPage: Int) {
        Task {
            do {
                defer { Task { @MainActor in progressState = .none } }
                let response = try await searchRepository.getSearchRepositories(query: query,
                                                                                sort: nil,
                                                                                order: nil,
                                                                                page: page,
                                                                                perPage: perPage)
                datasource.append(contentsOf: response.items)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func reset() {
        datasource.removeAll()
    }
}
