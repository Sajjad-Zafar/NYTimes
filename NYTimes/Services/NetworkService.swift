//
//  NetworkService.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation
import Combine

class NetworkService: NetworkServiceType {
    private let session: URLSession
    
    /// Creates a new `NetworkService` instance with the specified session.
    /// - Parameter session: session: The session used for making network requests. Default is `URLSessionConfiguration.default`.
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
    
    
    /// Loads data from the specified resource.
    /// - Parameter resource: The resource containing the URL and parameters for the request.
    /// - Returns: A publisher that emits the decoded data or an error.
    @discardableResult
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        guard let request = resource.request else {
            return .fail(NetworkError.invalidRequest)
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.invalidRequest }
            .print()
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return .fail(NetworkError.invalidResponse)
                }
                
                guard 200..<300 ~= response.statusCode else {
                    return .fail(NetworkError.dataLoadingError(statusCode: response.statusCode, data: data))
                }
                return .just(data)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
