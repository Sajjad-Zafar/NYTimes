//
//  NewsListingViewController.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit
import Combine

final class NewsListingViewController: UIViewController, StoryboardInstantiatable, ViewType  {
    
    // MARK: - Properties
    /// The name of the storyboard containing the view controller.
    static var storyboardName: String = "Main"
    /// The identifier of the view controller in the storyboard.
    static var storyboardIdentifier: String? = "NewsListingViewController"
    /// The view model for the news listing view.
    var viewModel: NewsListingViewModel!
    /// The set of cancellables to manage Combine subscriptions.
    private var cancellables = Set<AnyCancellable>()
    /// The subject used to trigger actions when the view appears.
    private let appear = PassthroughSubject<Void, Never>()
    /// The data source for the table view.
    private lazy var dataSource = makeDataSource()
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        performBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // send the trigger when view did appear
        appear.send(())
    }
    
    // MARK: - Private Functions
    /// Configures the UI appearance.
    private func configUI() {
        setupTableView()
    }
    
    /// Sets up the table view.
    private func setupTableView() {
        self.tableView.register(NewsListingCell.nib, forCellReuseIdentifier: NewsListingCell.reuseIdentifier)
        tableView.backgroundColor = .white
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        tableView.dataSource = dataSource
    }
    
    /// Performs the binding between the view model and the view controller.
    func performBinding() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let output = viewModel.transform(
            ViewModel.Input(
                appear: appear.eraseToAnyPublisher()
            )
        )
        appear.send()
        output.result
            .sink(receiveValue: { state in
                self.render(state)
            })
            .store(in: &cancellables)
    }

    /// Renders the given state to update the UI.
    private func render(_ state: NewsListingState) {
        switch state {
        case .idle, .noResults, .failure:
            toggleActivityIndicator(isHidden: true)
            update(with: [], animate: true)
        case .loading:
            toggleActivityIndicator(isHidden: false)
            update(with: [], animate: true)
        case .success(let newsViewModel):
            toggleActivityIndicator(isHidden: true)
            update(with: newsViewModel, animate: true)
        }
    }
    
    /// Toggles the visibility of the activity indicator.
    private func toggleActivityIndicator(isHidden: Bool) {
        activityIndicatorView.isHidden = isHidden
    }
}

// MARK: - UITableViewDataSource
extension NewsListingViewController {
    /// Represents the sections in the table view.
    enum Section: CaseIterable {
        case newsMainSection
    }

    /// Creates a data source for the table view.
    func makeDataSource() -> UITableViewDiffableDataSource<Section, NewsViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, newsModel in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListingCell.reuseIdentifier, for: indexPath) as? NewsListingCell else {
                    fatalError("Unable to dequeue reusable table view cell")
                }
                cell.bind(to: newsModel)
                return cell
            }
        )
    }
    
    /// Updates the table view with the given news data.
    func update(with news: [NewsViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, NewsViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(news, toSection: .newsMainSection)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

extension NewsListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModel.viewModel[indexPath.row]
        let newsDetail = NewsDetailViewController.instantiate(with: NewsDetailViewModel(newsViewModel: viewModel))
        self.navigationController?.pushViewController(newsDetail, animated: true)
    }
}

