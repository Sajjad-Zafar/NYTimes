//
//  ImageNetworkServiceType.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation
import Combine

/// A protocol that defines the network service behavior.
protocol NetworkServiceType: AnyObject {
    
    /// Loads a resource from the network.
    /// - Parameters:
    ///   - resource: The resource to load.
    /// - Returns: A publisher that emits the loaded resource or an error.
    @discardableResult
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error>
}

/// Defines the possible errors that can occur in the network service.
enum NetworkError: Error {
    
    /// Indicates an invalid request.
    case invalidRequest
    
    /// Indicates an invalid response.
    case invalidResponse
    
    /// Indicates an error occurred while loading data with a specific status code and data.
    case dataLoadingError(statusCode: Int, data: Data)
    
    /// Indicates an error occurred while decoding JSON data with a specific error.
    case jsonDecodingError(error: Error)
}
