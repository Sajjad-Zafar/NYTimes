//
//  NewsListingUITests.swift
//  NYTimesUITests
//
//  Created by Sajjad Zafar on 6/25/23.
//

import XCTest

let kExistsPredicate = NSPredicate(format: "exists == 1")
let kDoesNotExistsPredicate = NSPredicate(format: "exists == 0")
let kEnabledPredicate = NSPredicate(format: "enabled == 1")

let kMinTimeInterval = 15.0
let kAvgTimeInterval = 30.0
let kMaxTimeInterval = 50.0

final class NewsListingUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
        let app = XCUIApplication()
        app.launchArguments = ["isUITesting", "true"]
        app.launch()
    }
    
    
    override func tearDown() {
    }
    
    
    /// Run the app and wait for spinner to hide and then tap on index 2,
    /// we are supposing that data is greater than 2 results
    func test_NewsListingView_ShouldLoadingDataSuccessfully() {
        waitForSpinnerToBeCompleted(timeInterval: kAvgTimeInterval)
        
        let app = XCUIApplication()
        let newslistingCellId2 = app.tables["NewsListing.tableViewId"].cells["NewsListing.cellId.2"]
        let innerElement = newslistingCellId2.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(innerElement.exists)
        innerElement.tap()
        app.scrollViews.otherElements.staticTexts["NewsDetail.titleLabelId"].swipeUp()
        let backButton = app.navigationBars["NYTimes.NewsDetailView"].buttons["NYTimes Most Popular"]
        XCTAssertTrue(backButton.exists)
        backButton.tap()
    }

    func waitForSpinnerToBeCompleted(timeInterval: TimeInterval) {
        let app = XCUIApplication()
        let animationView = app/*@START_MENU_TOKEN@*/.otherElements["NewsListing.loadingViewId"].activityIndicators["In progress"]/*[[".otherElements[\"NewsListing.rootViewId\"]",".otherElements[\"NewsListing.loadingViewId\"].activityIndicators[\"In progress\"]",".activityIndicators[\"In progress\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[1]]@END_MENU_TOKEN@*/
        let notExists = expectation(for: kDoesNotExistsPredicate, evaluatedWith: animationView)
        wait(for: [notExists], timeout: timeInterval)
    }
}
