//
//  SearchTableViewCell.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/19.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    // TODO: - UI実装
    @IBOutlet private weak var previewLabel: UILabel!
    
    func apply(data: Repositories) {
        previewLabel.text = "\(data)"
    }
}
