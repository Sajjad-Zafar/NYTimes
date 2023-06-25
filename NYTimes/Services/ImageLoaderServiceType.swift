//
//  ImageLoaderServiceType.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit.UIImage
import Combine

/// A protocol that defines the image loader service behavior.
protocol ImageLoaderServiceType: AnyObject {
    
    /// Loads an image from the specified URL.
    /// - Parameters:
    ///   - url: The URL from which to load the image.
    /// - Returns: A publisher that emits the loaded image or `nil` if the image loading fails.
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}
