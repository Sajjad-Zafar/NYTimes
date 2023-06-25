//
//  MockImageLoaderService.swift
//  NYTimesTests
//
//  Created by Sajjad Zafar on 6/25/23.
//

import XCTest
import Combine
@testable import NYTimes

class MockImageLoaderService: ImageLoaderServiceType {
    
    var loadImageCalled = false
    var loadImageURL: URL?
    var mockImage: UIImage?
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        loadImageCalled = true
        loadImageURL = url
        
        if let mockImage = mockImage {
            return Just(mockImage).eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }
}
