//
//  ArticleTableViewCell.swift
//  MVVMSample
//
//  Created by taehy.k on 2021/07/30.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var articleDescLabel: UILabel!

    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Configure
    func configure(_ article: ArticleViewModel) {
        articleTitleLabel?.text = article.title
        articleDescLabel?.text = article.description
    }
}
