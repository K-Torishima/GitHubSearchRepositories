//
//  APIService.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation

protocol APIService {
    func request<T: RequestProtocol>(_ request: T) async throws -> T.Response
}
