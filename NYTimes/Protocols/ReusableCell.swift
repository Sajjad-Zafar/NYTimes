//
//  ReusableCell.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit

/// A protocol that defines reusable cell behavior for table view or collection view cells.
protocol ReusableCell {
    /// The identifier used to dequeue the reusable cell.
    static var reuseIdentifier: String { get }
    
    /// The nib used to load the reusable cell from a nib file.
    static var nib: UINib { get }
}

extension ReusableCell {
    /// The default implementation of the reuseIdentifier property.
    /// It uses the string representation of the conforming cell type as the identifier.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    /// The default implementation of the nib property.
    /// It creates a UINib instance with the same name as the reuseIdentifier.
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: .main)
    }
}
