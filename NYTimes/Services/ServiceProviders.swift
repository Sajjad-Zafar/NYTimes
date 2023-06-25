//
//  ServiceProviders.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation

class ServicesProvider {
    /// The network service used for making API requests.
    let network: NetworkServiceType
    /// The image loader service used for loading images.
    let imageLoader: ImageLoaderServiceType
    
    /// Creates a new `ServicesProvider` instance with the specified network and image loader services.
    /// - Parameters:
    ///   - network: The network service used for making API requests.
    ///   - imageLoader: The image loader service used for loading images.
    init(network: NetworkServiceType, imageLoader: ImageLoaderServiceType) {
        self.network = network
        self.imageLoader = imageLoader
    }
    
    /// Creates a default `ServicesProvider` instance with the default implementations of the network and image loader services.
    /// - Returns: A default `ServicesProvider` instance.
    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        let imageLoader = ImageLoaderService()
        return ServicesProvider(network: network, imageLoader: imageLoader)
    }
}

