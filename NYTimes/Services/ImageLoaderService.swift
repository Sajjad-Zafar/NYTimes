//
//  ImageService.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation
import UIKit.UIImage
import Combine

final class ImageLoaderService: ImageLoaderServiceType {
    private let cache: ImageCacheType = ImageCache()
    
    /// Loads an image from the specified URL.
    /// - Parameter url: The URL of the image to load.
    /// - Returns: A publisher that emits the loaded image or `nil` if the image loading fails.
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.image(for: url) {
            return .just(image)
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .catch { error in
                return Just(nil)
            }
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let image = image else { return }
                self.cache.insertImage(image, for: url)
            })
            .eraseToAnyPublisher()
    }
}

