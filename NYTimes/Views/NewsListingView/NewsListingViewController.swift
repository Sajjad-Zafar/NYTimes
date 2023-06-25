//
//  NewsListingViewController.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit
import Combine

final class NewsListingViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Private Functions
    private func configUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.register(NewsListingCell.nib, forCellReuseIdentifier: NewsListingCell.reuseIdentifier)
        tableView.backgroundColor = .white
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
    }
}
