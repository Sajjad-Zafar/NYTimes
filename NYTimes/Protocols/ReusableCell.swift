//
//  ReusableCell.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

extension ReusableCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: .main)
    }
}
