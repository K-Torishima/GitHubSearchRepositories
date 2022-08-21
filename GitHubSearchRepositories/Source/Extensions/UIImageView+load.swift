//
//  UIImageView+load.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/21.
//

import UIKit

extension UIImageView {
    func downloadImage(url: URL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, _ in
            if let imageData = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}
