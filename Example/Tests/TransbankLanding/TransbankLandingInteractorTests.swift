//
//  TransbankLandingInteractorTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import XCTest

class TransbankLandingInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: TransbankLandingInteractor!
    var spyPresenter: TransbankLandingPresentationLogicSpy!
    var spyWorker: TransbankLandingWorkerSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupTransbankLandingInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupTransbankLandingInteractor() {
        sut = TransbankLandingInteractor()

        spyPresenter = TransbankLandingPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = TransbankLandingWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles

    class TransbankLandingWorkerSpy: TransbankLandingWorker {}

    // MARK: Tests

     func testSetupUI() {
        // Given
        let request = TransbankLanding.Basic.Request()
        // When
        sut.setupUI(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentSetupUICalled,
            "setupUI should ask the presenter to format the result"
        )
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.title,
            "WELCOME_TITLE",
            "setupUI should pass the title to the presenter"
        )
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.subtitle,
            "WELCOME_SUBTITLE",
            "setupUI should pass the subtitle to the presenter"
        )
    }
}
