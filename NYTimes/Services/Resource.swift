//
//  Resource.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation

/// A struct representing a network resource.
struct Resource<T: Decodable> {
    
    /// The URL of the resource.
    let url: URL
    
    /// The parameters associated with the resource.
    let parameters: [String: CustomStringConvertible]
    
    /// The URL request representing the resource.
    var request: URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    /// Initializes a new resource with the given URL and parameters.
    /// - Parameters:
    ///   - url: The URL of the resource.
    ///   - parameters: The parameters associated with the resource.
    init(url: URL, parameters: [String: CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}
