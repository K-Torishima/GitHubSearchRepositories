//
//  SearchRepositoryImpl.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation

final class SearchRepositoryImpl: SearchRepository {
    
    private let apiService: APIService
    
    init(apiService: APIService = APIServiceImpl()) {
        self.apiService = apiService
    }
    
    func getSearchRepositories(query: String, sort: Sort?, order: Order?, page: Int?, perPage: Int?) async throws -> GitHubSearchAPIResponse {
        let request = GitHubSearchAPIRequest(query: query, sort: sort, order: order, page: page, perPage: perPage)
        let response = try await apiService.request(request)
        return response
    }
}
