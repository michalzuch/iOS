//
//  TestsUITests.swift
//  TestsUITests
//
//  Created by Michał Zuch on 30/01/2024.
//

import XCTest

final class TestsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let title = app.staticTexts["Tasks"]
        XCTAssertTrue(title.exists)

        let calculatorLabel = app.staticTexts["Calculator"]
        XCTAssertTrue(calculatorLabel.exists)
        let calculatorImage = app.images["Calculator"]
        XCTAssertTrue(calculatorImage.exists)
        calculatorLabel.tap()
        XCTAssertTrue(calculatorLabel.exists)
        app.navigationBars.buttons["Tasks"].tap()
        XCTAssertTrue(title.exists)

        let toDoLabel = app.staticTexts["To Do"]
        XCTAssertTrue(toDoLabel.exists)
        let toDoImage = app.staticTexts["To Do"]
        XCTAssertTrue(toDoImage.exists)
        toDoLabel.tap()
        XCTAssertTrue(toDoLabel.exists)
        app.navigationBars.buttons["Tasks"].tap()
        XCTAssertTrue(title.exists)

        let storeLabel = app.staticTexts["Store"]
        XCTAssertTrue(storeLabel.exists)
        let storeImage = app.staticTexts["Store"]
        XCTAssertTrue(storeImage.exists)
        storeLabel.tap()
        XCTAssertTrue(storeLabel.exists)
        app.navigationBars.buttons["Tasks"].tap()
        XCTAssertTrue(title.exists)

        let onlineStoreLabel = app.staticTexts["Online Store"]
        XCTAssertTrue(onlineStoreLabel.exists)
        let onlineStoreImage = app.staticTexts["Online Store"]
        XCTAssertTrue(onlineStoreImage.exists)
        onlineStoreLabel.tap()
        XCTAssertTrue(onlineStoreLabel.exists)
        app.navigationBars.buttons["Tasks"].tap()
        XCTAssertTrue(title.exists)

        let oAuthLabel = app.staticTexts["OAuth"]
        XCTAssertTrue(oAuthLabel.exists)
        oAuthLabel.tap()
        XCTAssertTrue(oAuthLabel.exists)
        app.navigationBars.buttons["Tasks"].tap()
        XCTAssertTrue(title.exists)

        let paymentsLabel = app.staticTexts["Payments"]
        XCTAssertTrue(paymentsLabel.exists)
        paymentsLabel.tap()
        XCTAssertTrue(paymentsLabel.exists)
        app.navigationBars.buttons["Tasks"].tap()
        XCTAssertTrue(title.exists)

        let testsLabel = app.staticTexts["Tests"]
        XCTAssertTrue(testsLabel.exists)
        testsLabel.tap()
        XCTAssertTrue(testsLabel.exists)
        app.navigationBars.buttons["Tasks"].tap()
        XCTAssertTrue(title.exists)

        let unknownImage = app.images.matching(identifier: "Unknown")
        XCTAssertEqual(unknownImage.count, 3)

        let cellToDelete = app.cells.firstMatch
        XCTAssertTrue(cellToDelete.exists)
        XCTAssertFalse(app.buttons["Delete"].exists)
        cellToDelete.swipeLeft()
        let deleteButton = app.buttons["Delete"]
        XCTAssertTrue(deleteButton.exists)
        deleteButton.tap()
        XCTAssertFalse(calculatorLabel.exists)

        let statusCell = app.cells.firstMatch
        XCTAssertTrue(statusCell.exists)
        XCTAssertFalse(app.buttons["Done"].exists)
        XCTAssertFalse(app.buttons["To Do"].exists)
        statusCell.swipeRight()
        var statusButton = app.buttons["Done"]
        XCTAssertTrue(app.buttons["Done"].exists)
        XCTAssertFalse(app.buttons["To Do"].exists)
        statusButton.tap()
        XCTAssertFalse(app.buttons["Done"].exists)
        XCTAssertFalse(app.buttons["To Do"].exists)
        statusCell.swipeRight()
        statusButton = app.buttons["To Do"]
        XCTAssertFalse(app.buttons["Done"].exists)
        XCTAssertTrue(app.buttons["To Do"].exists)
        statusButton.tap()
        XCTAssertFalse(app.buttons["Done"].exists)
        XCTAssertFalse(app.buttons["To Do"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
