//
//  YoutubeTableViewCell.swift
//  DelegateSample2
//
//  Created by taehy.k on 2021/09/03.
//

import UIKit

class YoutubeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    public static let cellId = "YoutubeTableViewCell"
    var youtuber: String?
    weak var delegate: YoutubeDelegate?

    // MARK: - UI Properties
    
    @IBOutlet weak var youtuberLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Configure
    
    public func configureCell(youtuber: String) {
        self.youtuber = youtuber
        youtuberLabel.text = youtuber
    }
    
    // MARK: - Actions
    
    @IBAction func subscribeButtonTapped(_ sender: Any) {
        if let youtuber = youtuber, let delegate = delegate {
            delegate.youtubeTableViewCell(self, youtuber: youtuber)
        }
    }
}
