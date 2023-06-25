//
//  StoryboardInstantiatable.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation

/// A protocol that defines the common behavior for objects that can be instantiated from storyboards.
public protocol StoryboardInstantiatable: AnyObject {
    /// The name of the storyboard that contains the object to be instantiated.
    static var storyboardName: String { get }
    
    /// The identifier of the object to be instantiated from the storyboard.
    static var storyboardIdentifier: String? { get }
}
