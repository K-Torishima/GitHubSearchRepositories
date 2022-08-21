//
//  SearchRepository.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation

protocol SearchRepository {
    func getSearchRepositories(query: String, sort: Sort?, order: Order?, page: Int?, perPage: Int?) async throws -> GitHubSearchAPIResponse
}
