//
//  AccessibilityIdentifier.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/26/23.
//

import Foundation

public struct AccessibilityIdentifiers {
    
    public struct NewsListing {
        public static let loadingViewID = "\(NewsListing.self).loadingViewId"
        public static let rootViewId = "\(NewsListing.self).rootViewId"
        public static let tableViewId = "\(NewsListing.self).tableViewId"
        public static let searchTextFieldId = "\(NewsListing.self).searchTextFieldId"
        public static let cellId = "\(NewsListing.self).cellId"
    }
    
    public struct NewsDetail {
        public static let rootViewId = "\(NewsDetail.self).rootViewId"
        public static let contentViewId = "\(NewsDetail.self).contentViewId"
        public static let titleLabelId = "\(NewsDetail.self).titleLabelId"
        public static let descriptionLabelId = "\(NewsDetail.self).descriptionLabelId"
    }
}
