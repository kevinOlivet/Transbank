//
//  TransbankLandingPresenterTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import XCTest

class TransbankLandingPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: TransbankLandingPresenter!
    var spyViewController: TransbankLandingDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupTransbankLandingPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupTransbankLandingPresenter() {
        sut = TransbankLandingPresenter()

        spyViewController = TransbankLandingDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests
    func testPresentSetupUI() {
        // Given
        let response = TransbankLanding.Basic.Response(
            title: "WELCOME_TITLE",
            subtitle: "WELCOME_TITLE"
        )
        // When
        sut.presentSetupUI(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displaySetupUICalled,
            "presentSetupUI should ask the view controller to display the result"
        )
        XCTAssertEqual(
            spyViewController.displaySetupUIViewModel?.title,
            "WELCOME_TITLE".localized,
            "presentMovements should localize the title"
        )
        XCTAssertEqual(
            spyViewController.displaySetupUIViewModel?.subtitle,
            "WELCOME_TITLE".localized,
            "presentMovements should localize the subtitle"
        )
    }
}
