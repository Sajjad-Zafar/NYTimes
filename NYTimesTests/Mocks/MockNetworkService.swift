//
//  MockNetworkService.swift
//  NYTimesTests
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation
import Combine
@testable import NYTimes

class MockNetworkService: NetworkServiceType {
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    @discardableResult
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> where T : Decodable {
        guard let _ = resource.request else {
            return .fail(NetworkError.invalidRequest)
        }
        
        // Load local JSON data instead of making a network request
        let jsonData = loadLocalJSONData()
        
        return Just(jsonData)
            .setFailureType(to: Error.self)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func loadLocalJSONData() -> Data {
        // Load your local JSON data here
        let testBundle = Bundle(for:  type(of: self))
        guard let url = testBundle.url(forResource: "mockData", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load local JSON data")
        }
        return data
    }
}


