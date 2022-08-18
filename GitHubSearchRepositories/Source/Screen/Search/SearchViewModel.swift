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
    
    enum DisplayState {
        case initial
        case main
    }
    
    enum ProgressState {
        case none
        case fetch
    }
    
    // Publisher
    @Published private (set) var displayState: DisplayState = .initial
    @Published private (set) var progressState: ProgressState = .none
    @Published private (set) var datasource: [Repositories] = []
    
    private var page: Int = 1
    private let perPage: Int = 20
    
    private let searchRepository: SearchRepository
    
    init(searchRepository: SearchRepository = SearchRepositoryImpl()) {
        self.searchRepository = searchRepository
    }
    
    func viewDidLoad() {
    }
    
    func apply(searchText: String) {
        reset()
        fetchRepositories(query: searchText, page: page, perPage: perPage)
        
    }
    
    func didSelectRowAt(_ row: Int) {
        let data = datasource[row]
        print(data)
    }
    
    private func fetchRepositories(query: String, page: Int, perPage: Int) {
        progressState = .fetch
        Task {
            do {
                defer { Task { @MainActor in progressState = .none } }
                let response = try await searchRepository.getSearchRepositories(query: query,
                                                                                sort: nil,
                                                                                order: nil,
                                                                                page: page,
                                                                                perPage: perPage)
                datasource.append(contentsOf: response.items)
                print(response.items)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func reset() {
        datasource.removeAll()
    }
    
}
