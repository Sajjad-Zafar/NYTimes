//
//  NewsListingViewModel.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation
import Combine
import UIKit.UIImage

/// Represents the possible states of the news listing.
public enum NewsListingState {
    case idle
    case loading
    case success([NewsViewModel])
    case noResults
    case failure(Error)
}

/// The view model for the news listing screen.
class NewsListingViewModel: ViewModelType {
    
    // MARK: - Input
    /// The input for the view model.
    struct Input {
        let appear: AnyPublisher<Void, Never>
    }
    
    // MARK: - Output
    /// The output for the view model.
    struct Output {
        let result: AnyPublisher<NewsListingState, Never>
    }
    
    // MARK: - Properites
    /// The network service for fetching news data.
    var networkService: NetworkServiceType
    /// The image loader service for loading news images.
    var imageLoaderService: ImageLoaderServiceType
    /// The cancellables to manage subscriptions.
    private var cancellables: [AnyCancellable] = []
    /// The publisher for publishing news listing states.
    private var resultsPublisher: PassthroughSubject<NewsListingState, Never>
    /// The array of news view models.
    private var newsViewModel: [NewsViewModel] = []
    /// returns the array of news view model
    var viewModel: [NewsViewModel] {
        return newsViewModel
    }
    
    // MARK: - Init
    init(service: NetworkServiceType, imageLoader: ImageLoaderServiceType) {
        self.networkService = service
        self.imageLoaderService = imageLoader
        resultsPublisher = PassthroughSubject<NewsListingState, Never>()
    }
    
    /// Converts an array of `NewsResults` to an array of `NewsViewModel`.
    private func viewModels(from results: [NewsResults]?) -> [NewsViewModel] {
        guard let results = results else {
            return []
        }
        let newsViewmodel = results.map({[unowned self] news in
            return build(news: news)
        })
        self.newsViewModel = newsViewmodel
        return newsViewmodel
    }
    
    func transform(_ input: Input) -> Output {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        input.appear
            .flatMap({ [unowned self] in
                self.fetchMostPopularNews()
            })
            .map({ result -> NewsListingState in
                switch result {
                case .success(let news):
                    return .success(self.viewModels(from: news.results))
                case .failure(let error):
                    return .failure(error)
                }
            })
            .sink(receiveValue: { [weak self] state in
                self?.resultsPublisher.send(state)
            })
            .store(in: &cancellables)

        return Output(
            result: resultsPublisher.eraseToAnyPublisher()
        )
    }
    
    // MARK: - Networking Functions
    /// Fetches the most popular news.
    func fetchMostPopularNews() -> AnyPublisher<Result<NewsModel, Error>, Never> {
        return networkService
            .load(Resource<NewsModel>.popularNews())
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<NewsModel, Error>, Never> in
                .just(.failure(error))
            }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    /// Loads the image for a news result.
    func loadImage(for newsResult: NewsResults) -> AnyPublisher<UIImage?, Never> {
        return Deferred {
            return Just(newsResult.media?.first?.mediaMetadata?.last?.url)
        }
        .flatMap({[unowned self] poster -> AnyPublisher<UIImage?, Never> in
            guard let poster = newsResult.media?.first?.mediaMetadata?.last?.url, let url = URL(string: poster) else {
                return Empty().eraseToAnyPublisher()
            }
            return self.imageLoaderService.loadImage(from: url)
        })
        .subscribe(on: Scheduler.backgroundWorkScheduler)
        .receive(on: Scheduler.mainScheduler)
        .share()
        .eraseToAnyPublisher()
    }
    
    /// Builds a `NewsViewModel` from a news result.
    func build(news: NewsResults) -> NewsViewModel {
        return NewsViewModel(id: news.id ?? 0, title: news.title ?? "", abstract: news.abstract ?? "", section: news.section ?? "", byLine: news.byline ?? "", type: news.type ?? "", poster: loadImage(for: news), publishedDate: news.publishedDate ?? "")
    }
}
