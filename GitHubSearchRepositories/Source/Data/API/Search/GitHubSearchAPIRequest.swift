//
//  GitHubSearchAPIRequest.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation

struct GitHubSearchAPIRequest: RequestProtocol {
    typealias Response = GitHubSearchAPIResponse
    
    var path: String {
        return "/search/repositories"
    }
    
    var method: HttpMethod {
        .get
    }
    
    var parameters: [String : String] {
        var parames: [String: String] = [:]
        
        parames["q"] = query
        
        if let sort = sort {
            parames["sort"] = sort.rawValue
        }
        
        if let order = order {
            parames["order"] = order.rawValue
        }
        
        if let page = page {
            parames["page"] = "\(page)"
        }
        
        if let perPage = perPage {
            parames["per_page"] = "\(perPage)"
        }
        
        return parames
    }
    
    private let query: String
    private let sort: Sort?
    private let order: Order?
    private let page: Int?
    private let perPage: Int?
    
    init(query: String, sort: Sort?, order: Order?, page: Int?, perPage: Int?) {
        self.query = query
        self.sort = sort
        self.order = order
        self.page = page
        self.perPage = perPage
    }
}
