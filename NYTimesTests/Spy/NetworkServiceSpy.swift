//
//  NetworkServiceSpy.swift
//  NYTimesTests
//
//  Created by Sajjad Zafar on 6/25/23.
//

import XCTest
import Combine
@testable import NYTimes

class NetworkServiceSpy: NetworkService {
    
    var loadCalled = false
    var mockData: Data?
    var mockError: Error?
    
    override func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        loadCalled = true
        
        if let mockData = mockData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: mockData)
                return Just(decodedData).setFailureType(to: Error.self).eraseToAnyPublisher()
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        
        if let mockError = mockError {
            return Fail(error: mockError).eraseToAnyPublisher()
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
