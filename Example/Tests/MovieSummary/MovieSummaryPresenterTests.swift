//
//  MovieSummaryPresenterTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import XCTest

class MovieSummaryPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieSummaryPresenter!
    var spyViewController: MovieSummaryDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieSummaryPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieSummaryPresenter() {
        sut = MovieSummaryPresenter()

        spyViewController = MovieSummaryDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

    func testPresentSetupUI() {
        // Given
        let response = MovieSummary.Texts.Response(title: "testTitle")
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
        let response = MovieSummary.Failure.Response(errorType: .internet)
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
        let item = MovieSummary.Success.Response.SingleMovieResponse(
            titleLabel: "testTitle",
            releaseDateTitleLabel: "RELEASE_DATE",
            releaseDateLabel: "testRelease",
            popularityTitleLabel: "POPULARITY",
            popularityLabel: 1234.5,
            voteAverageTitleLabel: "VOTE_AVERAGE",
            voteAverageLabel: 432.1,
            identifier: 123
        )
        let response = MovieSummary.Success.Response(movieArray: [item])
        // When
        sut.presentMovieList(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displayMovieArrayCalled,
            "presentPaymentMethods should ask the view controller to displayPaymentMethodArray"
        )
        XCTAssertEqual(
            spyViewController.displayMovieArrayViewModel?.movieArray.first?.titleLabel,
            "testTitle",
            "the data should match what is passed"
        )
        XCTAssertEqual(
            spyViewController.displayMovieArrayViewModel?.movieArray.first?.releaseDateTitleLabel,
            "Release date:",
            "the data should be localized"
        )
        XCTAssertEqual(
            spyViewController.displayMovieArrayViewModel?.movieArray.first?.releaseDateLabel,
            "testRelease",
            "the data should be localized"
        )
        XCTAssertEqual(
            spyViewController.displayMovieArrayViewModel?.movieArray.first?.popularityTitleLabel,
            "Popularity:",
            "the data should be localized"
        )
        XCTAssertEqual(
            spyViewController.displayMovieArrayViewModel?.movieArray.first?.popularityLabel,
            "1234.5",
            "the data should be localized"
        )
        XCTAssertEqual(
            spyViewController.displayMovieArrayViewModel?.movieArray.first?.voteAverageTitleLabel,
            "Vote average:",
            "the data should be localized"
        )
        XCTAssertEqual(
            spyViewController.displayMovieArrayViewModel?.movieArray.first?.voteAverageLabel,
            "432.1",
            "the data should be localized"
        )
    }
    func testPresentSelectedMovie() {
        // Given
        let response = MovieSummary.MovieDetail.Response()
        // When
        sut.presentSelectedMovie(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.showSelectedMovieCalled,
            "showBankSelect should ask the view controller to showBankSelect"
        )
    }
}
