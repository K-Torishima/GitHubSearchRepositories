//
//  SearchRouting.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import UIKit

protocol SearchRouting: AnyObject {
    func navigateDetail(data: Repositories)
}

extension SearchRouting where Self: UIViewController {
    func navigateDetail(data: Repositories) {
        // 詳細画面に遷移する
        print("詳細画面に遷移, data: \(data)")
    }
}
