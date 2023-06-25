//
//  ViewModelType.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation

/// A protocol that defines the common behavior for view model types.
public protocol ViewModelType {
    /// The associated type for the input of the view model.
    associatedtype Input
    
    /// The associated type for the output of the view model.
    associatedtype Output
    
    /// Transforms the input into the corresponding output.
    /// - Parameter input: The input values for the transformation.
    /// - Returns: The output result of the transformation.
    func transform(_ input: Input) -> Output
}
