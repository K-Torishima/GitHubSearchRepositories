//
//  SearchTableViewCell.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/19.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.backgroundColor = .lightGray
            avatarImageView.layer.cornerRadius = 6
            avatarImageView.layer.borderWidth = 0.5
            avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var descriptionlabel: UILabel!
    @IBOutlet private weak var stargazersCountLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    
    func apply(data: Repositories) {
        avatarImageView.downloadImage(url: data.owner.avatarUrl)
        nameLabel.text = data.name
        loginLabel.text = data.owner.login
        descriptionlabel.text = data.description
        stargazersCountLabel.text = "\(data.stargazersCount)"
        languageLabel.text = data.language
    }
}
