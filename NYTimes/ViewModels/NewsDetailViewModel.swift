//
//  NewsDetailViewModel.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation
import Combine

class NewsDetailViewModel: ViewModelType {
    
    // MARK: - Input
    struct Input {
    }
    
    // MARK: - Output
    struct Output {
    }
    
    // MARK: - Properites
    private (set) var newsViewModel: NewsViewModel?
    private var cancellables = Set<AnyCancellable>()

    
    init(newsViewModel: NewsViewModel) {
        self.newsViewModel = newsViewModel
    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
