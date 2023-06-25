//
//  NewsDetailViewController.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit
import Combine

final class NewsDetailViewController: UIViewController, StoryboardInstantiatable, ViewType {

    //MARK: - Properties
    static var storyboardName: String = "Main"
    static var storyboardIdentifier: String? = "NewsDetailViewController"
    var viewModel: NewsDetailViewModel!
    private var cancellable: AnyCancellable?
    
    // MARK: - IBOutlets
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        populateDetail()
    }
    
    func performBinding() {
        _ = viewModel.transform(
            ViewModel.Input()
        )
    }
    
    private func configUI() {
        view.accessibilityIdentifier = AccessibilityIdentifiers.NewsDetail.rootViewId
        titleLabel.accessibilityIdentifier = AccessibilityIdentifiers.NewsDetail.titleLabelId
        abstractLabel.accessibilityIdentifier = AccessibilityIdentifiers.NewsDetail.descriptionLabelId
    }
    
    private func populateDetail() {
        cancellable = viewModel.newsViewModel?.poster.sink { [unowned self] image in
            self.showImage(image: image)
        }
        typeLabel.text = viewModel.newsViewModel?.type
        sectionLabel.text = viewModel.newsViewModel?.section
        titleLabel.text = viewModel.newsViewModel?.title
        abstractLabel.text = viewModel.newsViewModel?.abstract
        byLineLabel.text = viewModel.newsViewModel?.byLine
        publishedDateLabel.text = viewModel.newsViewModel?.publishedDate
    }
    
    private func showImage(image: UIImage?) {
        cancelImageLoading()
        UIView.transition(with: self.newsImageView,
            duration: 0.3,
            options: [.curveEaseOut, .transitionCrossDissolve],
            animations: {
                self.newsImageView.image = image
        })
    }
    
    private func cancelImageLoading() {
        newsImageView.image = nil
        cancellable?.cancel()
    }
}
