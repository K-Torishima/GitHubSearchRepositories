//
//  GitHubSearchAPIResponse.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation

struct GitHubSearchAPIResponse: APIResponse {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repositories]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
