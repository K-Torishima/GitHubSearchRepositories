//
//  UITableView+Register.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import UIKit

extension UITableView {
    func dequeue<T: NibInstantiatable & NSObject>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("\(self)のDequeに失敗")
        }
        return cell
    }
}

extension UITableView {
    func registerCell<T: UITableViewCell>(_: T.Type) {
        register(UINib(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }
}
