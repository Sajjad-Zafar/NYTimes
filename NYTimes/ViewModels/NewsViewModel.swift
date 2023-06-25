//
//  NewsViewModel.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Combine
import UIKit.UIImage

/// The view model representing a news item with the data that needs to be populated.
public struct NewsViewModel {
    /// The unique identifier of the news item.
    let id: Int
    /// The title of the news item.
    let title: String
    /// The abstract or summary of the news item.
    let abstract: String
    /// The section to which the news item belongs.
    let section: String
    /// The type of the news item.
    let type: String
    /// The byline or author of the news item.
    let byLine: String
    /// The type of news.
    let newsType: String
    /// The publisher that provides the news item's poster image.
    let poster: AnyPublisher<UIImage?, Never>
    /// The published date of the news item.
    let publishedDate: String
    
    /// Initializes a new instance of `NewsViewModel`.
    /// - Parameters:
    ///   - id: The unique identifier of the news item.
    ///   - title: The title of the news item.
    ///   - abstract: The abstract or summary of the news item.
    ///   - section: The section to which the news item belongs.
    ///   - byLine: The byline or author of the news item.
    ///   - type: The type of the news item.
    ///   - poster: The publisher that provides the news item's poster image.
    ///   - publishedDate: The published date of the news item.
    init(id: Int, title: String, abstract: String, section: String, byLine: String, type: String, poster: AnyPublisher<UIImage?, Never>, publishedDate: String) {
        self.id = id
        self.title = title
        self.abstract = abstract
        self.section = section
        self.type = type
        self.byLine = byLine
        self.newsType = type
        self.poster = poster
        self.publishedDate = publishedDate
    }
}

extension NewsViewModel: Hashable {
    /// Compares two `NewsViewModel` instances for equality.
    /// - Parameters:
    ///   - lhs: The left-hand side `NewsViewModel` instance to compare.
    ///   - rhs: The right-hand side `NewsViewModel` instance to compare.
    /// - Returns: `true` if the `id` property of both instances is equal; otherwise, `false`.
    public static func == (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// Hashes the essential components of the `NewsViewModel` instance into the specified hasher.
    /// - Parameter hasher: The hasher to use in the hashing process.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
