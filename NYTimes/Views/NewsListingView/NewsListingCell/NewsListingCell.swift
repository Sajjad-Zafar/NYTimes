//
//  NewsListingCell.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit
import Combine

class NewsListingCell: UITableViewCell, ReusableCell {

    // MARK: - IBOutlets
    /// The label displaying the news title.
    @IBOutlet weak var titleLabel: UILabel!
    /// The label displaying the author name.
    @IBOutlet weak var byLineLabel: UILabel!
    /// The label displaying the news section.
    @IBOutlet weak var sectionLabel: UILabel!
    /// The image view displaying the news image.
    @IBOutlet weak var newsImageView: UIImageView!
    /// The label displaying the published date of the news.
    @IBOutlet weak var publishedDateLabel: UILabel!

    // MARK: - Properties
    /// The cancellable object to manage the image loading subscription.
    private var cancellable: AnyCancellable?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cancelImageLoading()
        newsImageView.layer.cornerRadius = newsImageView.bounds.size.width / 2
        newsImageView.clipsToBounds = true
    }
    
    /// Binds the data from the `NewsViewModel` to the cell's UI elements.
    /// - Parameter viewModel: The `NewsViewModel` to bind to the cell.
    func bind(to viewModel: NewsViewModel) {
        cancelImageLoading()
        titleLabel.text = viewModel.title
        byLineLabel.text = viewModel.byLine
        sectionLabel.text = viewModel.newsType
        cancellable = viewModel.poster.sink { [unowned self] image in
            self.showImage(image: image)
        }
    }

    /// Displays the image in the image view with a cross dissolve animation.
    /// - Parameter image: The image to display.
    private func showImage(image: UIImage?) {
        cancelImageLoading()
        UIView.transition(with: self.newsImageView,
            duration: 0.3,
            options: [.curveEaseOut, .transitionCrossDissolve],
            animations: {
                self.newsImageView.image = image
        })
    }
    
    /// Cancels the image loading and resets the image view.
    private func cancelImageLoading() {
        newsImageView.image = nil
        cancellable?.cancel()
    }
}
