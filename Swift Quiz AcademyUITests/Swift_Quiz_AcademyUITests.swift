//
//  Swift_Quiz_AcademyUITests.swift
//  Swift Quiz AcademyUITests
//

import XCTest

final class Swift_Quiz_AcademyUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-resetUserDefaultsForUITests"]
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testAppLaunchShowsHome() throws {
        launchApp()

        XCTAssertTrue(app.staticTexts["Swift Quiz Academy"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["startQuizButton"].exists)
    }

    @MainActor
    func testStartQuizOpensCategorySelection() throws {
        launchApp()
        app.buttons["startQuizButton"].tap()

        XCTAssertTrue(app.buttons["categoryButton_swift-basics"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testCompleteQuizShowsResult() throws {
        launchApp()
        app.buttons["startQuizButton"].tap()
        app.buttons["categoryButton_swift-basics"].tap()

        for _ in 0..<21 {
            let correctAnswer = app.buttons["answerButton_correct"]
            XCTAssertTrue(correctAnswer.waitForExistence(timeout: 5))
            correctAnswer.tap()

            let seeResult = app.buttons["seeResultButton"]
            if seeResult.exists {
                seeResult.tap()
                break
            }

            let nextQuestion = app.buttons["nextQuestionButton"]
            XCTAssertTrue(nextQuestion.waitForExistence(timeout: 5))
            nextQuestion.tap()
        }

        XCTAssertTrue(app.buttons["Review Answers"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testOpenSettings() throws {
        launchApp()
        app.tabBars.buttons["Settings"].tap()

        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testOpenLibrary() throws {
        launchApp()
        app.tabBars.buttons["Library"].tap()

        XCTAssertTrue(app.navigationBars["Library"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Questions"].exists)
    }

    private func launchApp() {
        app.launch()
        dismissDailyRewardIfNeeded()
    }

    private func dismissDailyRewardIfNeeded() {
        let claimButton = app.buttons["claimDailyRewardButton"]
        if claimButton.waitForExistence(timeout: 2) {
            claimButton.tap()
            _ = claimButton.waitForNonExistence(timeout: 3)
        }
    }
}
