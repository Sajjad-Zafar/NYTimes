//
//  ImageCacheType.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit

protocol ImageCacheType: AnyObject {
    
    /// Retrieves the image associated with the specified URL from the cache.
    /// - Parameter url: The URL of the image.
    /// - Returns: The cached image if available, otherwise `nil`.
    func image(for url: URL) -> UIImage?
    
    /// Inserts the image into the cache for the specified URL.
    /// - Parameters:
    ///   - image: The image to be inserted into the cache.
    ///   - url: The URL of the image.
    func insertImage(_ image: UIImage?, for url: URL)
    
    /// Removes the cached image associated with the specified URL from the cache.
    /// - Parameter url: The URL of the image to be removed.
    func removeImage(for url: URL)
    
    /// Removes all images from the cache.
    func removeAllImages()
    
    /// Provides subscript access to the cached images using URL as the key.
    /// - Parameter url: The URL of the image.
    /// - Returns: The cached image if available, otherwise `nil`.
    subscript(_ url: URL) -> UIImage? { get set }
}
