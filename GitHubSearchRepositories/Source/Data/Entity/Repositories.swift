//
//  Repositories.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation

struct Repositories: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let htmlUrl: URL
    let contributorsUrl: URL
    let description: String?
    let url: URL
    let createdAt: String
    let updatedAt: String
    let homepage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let defaultBranch: String

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case htmlUrl = "html_url"
        case contributorsUrl = "contributors_url"
        case description
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case defaultBranch = "default_branch"
    }
}
