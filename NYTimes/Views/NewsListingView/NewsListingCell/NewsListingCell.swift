//
//  NewsListingCell.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit

class NewsListingCell: UITableViewCell, ReusableCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        newsImageView.layer.cornerRadius = newsImageView.bounds.size.width / 2
        newsImageView.clipsToBounds = true
    }
}
