//
//  Motivator1UITests.swift
//  Motivator1UITests
//
//  Created by Mathias Larsen on 04/05/2019.
//  Copyright © 2019 Mathias Larsen. All rights reserved.
//

import XCTest

class Motivator1UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Second"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let submitElementsQuery = scrollViewsQuery.otherElements.containing(.button, identifier:"Submit")
        submitElementsQuery.children(matching: .other).element(boundBy: 1).buttons["Button"].tap()
        submitElementsQuery.children(matching: .other).element(boundBy: 2).buttons["Button"].tap()
        submitElementsQuery.children(matching: .other).element(boundBy: 3).buttons["Button"].tap()
        submitElementsQuery.children(matching: .other).element(boundBy: 4).buttons["Button"].tap()
        submitElementsQuery.children(matching: .other).element(boundBy: 5).buttons["Button"].tap()
        scrollViewsQuery.otherElements.buttons["Submit"].tap()
        
        let messageLable = XCUIApplication().staticTexts["messageLabel"].label
        XCTAssertEqual(messageLable, "You gained 250.0 xp")
    }

}
