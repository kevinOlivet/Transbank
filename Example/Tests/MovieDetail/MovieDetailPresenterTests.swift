//
//  MovieDetailPresenterTests.swift
//  Transbank
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import Transbank
import XCTest

class MovieDetailPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieDetailPresenter!
    var spyViewController: MovieDetailDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieDetailPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailPresenter() {
        sut = MovieDetailPresenter()

        spyViewController = MovieDetailDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests
    func testPresentSetupUI() {
        // Given
        let response = MovieDetail.Texts.Response(title: "testTitle")
        // When
        sut.presentSetupUI(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displaySetupUICalled,
            "presentSetupUI should ask the view controller to display the result"
        )
        XCTAssertEqual(
            spyViewController.displaySetupUIViewModel?.title,
            "testTitle",
            "presentSetupUI should format the title"
        )
    }
    func testPresentLoadingView() {
        // Given
        // When
        sut.presentLoadingView()
        // Then
        XCTAssertTrue(
            spyViewController.displayLoadingViewCalled,
            "presentLoadingView should ask the view controller to displayLoadingView"
        )
    }
    func testHideLoadingView() {
        // Given
        // When
        sut.presentHideLoadingView()
        // Then
        XCTAssertTrue(
            spyViewController.hideLoadingViewCalled,
            "hideLoadingView should ask the view controller to hideLoadingView"
        )
    }
    func testPresentErrorAlert() {
        // Given
        let response = MovieDetail.Failure.Response(errorType: .internet)
        // When
        sut.presentErrorAlert(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displayErrorAlertCalled,
            "presentErrorAlert should ask the view controller to displayErrorAlert"
        )
        XCTAssertEqual(
            spyViewController.displayErrorAlertViewModel?.errorType,
            .internet,
            "the presenter should pass the response"
        )
    }
    func testPresentMovieList() {
        // Given
        let response = MovieDetail.Success.Response(
            titleLabel: "testtitleLabel",
            overviewLabel: "testoverviewLabel",
            budgetLabel: 123,
            revenueLabel: 456,
            homepageLabel: "testhomepageLabel",
            genreLabel: "testgenreLabel",
            productionCompanyLabel: "testproductionCompanyLabel",
            runtimeLabel: 789
        )
        // When
        sut.presentMovieDetail(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displayMovieDetailCalled,
            "presentPaymentMethods should ask the view controller to displayPaymentMethodArray"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.titleLabel,
            "testtitleLabel",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.overviewLabel,
            "testoverviewLabel",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.budgetLabel,
            "Budget: $123",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.revenueLabel,
            "Revenue: $456",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.homepageLabel,
            "testhomepageLabel",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.genreLabel,
            "testgenreLabel",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.productionCompanyLabel,
            "testproductionCompanyLabel",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieDetailViewModel?.runtimeLabel,
            "789 minutes",
            "the data should match what is passed"
        )
    }
}
