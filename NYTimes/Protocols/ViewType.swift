//
//  ViewType.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit

/// A protocol that defines the common behavior for a view in the MVVM architecture.
public protocol ViewType: AnyObject {
    /// The associated view model type for the view.
    associatedtype ViewModel: ViewModelType
    
    /// The view model instance associated with the view.
    var viewModel: ViewModel! { get set }
    
    /// Instantiates a view with the provided view model.
    /// - Parameter viewModel: The view model to associate with the view.
    /// - Returns: An instance of the view associated with the provided view model.
    static func instantiate(with viewModel: ViewModel) -> Self
    
    /// Performs the binding between the view and the view model.
    func performBinding()
}

/// An extension on `ViewType` that provides default implementation for view instantiation using storyboards.
extension ViewType where Self: UIViewController & StoryboardInstantiatable {
    
    /// Instantiates a view with the provided view model using a storyboard.
    /// - Parameter viewModel: The view model to associate with the view.
    /// - Returns: An instance of the view associated with the provided view model.
    static func instantiate(with viewModel: ViewModel) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        if let identifier = storyboardIdentifier {
            guard let vc = storyboard.instantiateViewController(identifier: identifier) as? Self else {
                preconditionFailure("Unable to instantiate \(Self.self) from the storyboard named \(storyboardName) with identifier \(identifier)")
            }
            vc.viewModel = viewModel
            return vc
        }
        
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            preconditionFailure("Unable to instantiate initial \(Self.self) from the storyboard named \(storyboardName)")
        }
        vc.viewModel = viewModel
        return vc
    }
}
