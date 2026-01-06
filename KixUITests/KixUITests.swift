//
//  KixUITests.swift
//  KixUITests
//
//  Created by Konstanty Halets on 06/01/2026.
//

import XCTest

final class KixUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

    @MainActor
    func testLoginFlow() throws {
        let app = XCUIApplication()
        app.launch()
        let emailField = app.textFields["login_email_field"]
        let passwordField = app.secureTextFields["login_password_field"]
        let loginButton = app.buttons["login_button"]
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(passwordField.exists)
        XCTAssertTrue(loginButton.exists)
        emailField.tap()
        emailField.typeText("test@example.com")
        passwordField.tap()
        passwordField.typeText("password")
        loginButton.tap()
        // Check for main tab bar after login
        XCTAssertTrue(app.tabBars.buttons["tab_home"].exists)
    }

    @MainActor
    func testAddToCart() throws {
        let app = XCUIApplication()
        app.launch()
        // Login first
        let emailField = app.textFields["login_email_field"]
        if emailField.exists {
            emailField.tap()
            emailField.typeText("test@example.com")
            let passwordField = app.secureTextFields["login_password_field"]
            passwordField.tap()
            passwordField.typeText("password")
            app.buttons["login_button"].tap()
        }
        // Add to cart from first product card
        let addToCartButton = app.buttons.matching(identifier: "add_to_cart_button_").firstMatch
        XCTAssertTrue(addToCartButton.waitForExistence(timeout: 2))
        addToCartButton.tap()
        app.tabBars.buttons["tab_cart"].tap()
        XCTAssertTrue(app.staticTexts["cart_total_price"].exists)
    }

    @MainActor
    func testSwitchTabs() throws {
        let app = XCUIApplication()
        app.launch()
        // Login first
        let emailField = app.textFields["login_email_field"]
        if emailField.exists {
            emailField.tap()
            emailField.typeText("test@example.com")
            let passwordField = app.secureTextFields["login_password_field"]
            passwordField.tap()
            passwordField.typeText("password")
            app.buttons["login_button"].tap()
        }
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.buttons["tab_home"].exists)
        XCTAssertTrue(tabBar.buttons["tab_notes"].exists)
        XCTAssertTrue(tabBar.buttons["tab_favorites"].exists)
        XCTAssertTrue(tabBar.buttons["tab_menu"].exists)
        XCTAssertTrue(tabBar.buttons["tab_cart"].exists)
        tabBar.buttons["tab_favorites"].tap()
        XCTAssertTrue(app.staticTexts["favorites_title"].exists)
    }

    @MainActor
    func testFavoriteProduct() throws {
        let app = XCUIApplication()
        app.launch()
        // Login first
        let emailField = app.textFields["login_email_field"]
        if emailField.exists {
            emailField.tap()
            emailField.typeText("test@example.com")
            let passwordField = app.secureTextFields["login_password_field"]
            passwordField.tap()
            passwordField.typeText("password")
            app.buttons["login_button"].tap()
        }
        let favoriteButton = app.buttons.matching(identifier: "favorite_button_").firstMatch
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 2))
        favoriteButton.tap()
        app.tabBars.buttons["tab_favorites"].tap()
        XCTAssertTrue(app.staticTexts["favorites_title"].exists)
    }

    @MainActor
    func testCheckoutButtonTap() throws {
        let app = XCUIApplication()
        app.launch()
        // Login first
        let emailField = app.textFields["login_email_field"]
        if emailField.exists {
            emailField.tap()
            emailField.typeText("test@example.com")
            let passwordField = app.secureTextFields["login_password_field"]
            passwordField.tap()
            passwordField.typeText("password")
            app.buttons["login_button"].tap()
        }
        // Add to cart if needed
        let addToCartButton = app.buttons.matching(identifier: "add_to_cart_button_").firstMatch
        if addToCartButton.exists {
            addToCartButton.tap()
        }
        app.tabBars.buttons["tab_cart"].tap()
        let checkoutButton = app.buttons["checkout_button"]
        XCTAssertTrue(checkoutButton.exists)
        checkoutButton.tap()
        // Optionally check for confirmation UI
    }
}
