//
//  Resource+News.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation

extension Resource {
    
    /// Convenience method for creating a `Resource` instance for retrieving popular news.
    /// - Returns: A `Resource` instance for retrieving popular news.
    static func popularNews() -> Resource<NewsModel> {
        let url = ApiConstants.baseUrl.appendingPathComponent("mostpopular/v2/mostviewed/all-sections/30.json")
        let parameters: [String : CustomStringConvertible] = [
            "api-key": ApiConstants.apiKey
        ]
        return Resource<NewsModel>(url: url, parameters: parameters)
    }
}
