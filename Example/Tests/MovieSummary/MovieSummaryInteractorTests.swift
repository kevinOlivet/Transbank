//
//  MovieSummaryInteractorTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons
@testable import Transbank
import XCTest

class MovieSummaryInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieSummaryInteractor!
    var spyPresenter: MovieSummaryPresentationLogicSpy!
    var spyWorker: MovieSummaryWorkerSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieSummaryInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieSummaryInteractor() {
        sut = MovieSummaryInteractor()

        spyPresenter = MovieSummaryPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = MovieSummaryWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles

    enum PossibleResults {
        case success
        case parsingFail
        case failure
    }

    class MovieSummaryWorkerSpy: MovieSummaryWorker {
        var theResult: PossibleResults = .success
        var getMovieListCalled = false

        override func getMovieList(
            successCompletion: @escaping (MovieSummaryResult?) -> Void,
            failureCompletion: @escaping (NTError) -> Void
        ) {
            getMovieListCalled = true
            switch theResult {
            case .success:
                let item = MovieSummaryResult.Result(
                    popularity: 123,
                    id: 34,
                    title: "testTitle",
                    voteAverage: 123,
                    overview: "testOverview",
                    releaseDate: "testReleaseDate"
                )
                let model = MovieSummaryResult(results: [item])
                successCompletion(model)
            case .parsingFail:
                successCompletion(nil)
            case .failure:
                let error = NTError.noInternetConection
                failureCompletion(error)
            }
        }
    }

    // MARK: Tests

    func testPrepareSetUpUI() {
        // Given
        let request = MovieSummary.Texts.Request()
        // When
        sut.prepareSetUpUI(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentSetupUICalled,
            "prepareSetUpUI should ask the presenter to format the result"
        )
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.title,
            "SELECT_MOVIE",
            "should match the data"
        )
    }
    func testFetchMovieListSuccess() {
        // Given
        spyWorker.theResult = .success
        let request = MovieSummary.Success.Request()
        // When
        sut.fetchMovieList(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentMovieListCalled,
            "fetchPaymentMethods with success should call presenter presentPaymentMethods"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.titleLabel,
            "testTitle",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.releaseDateTitleLabel,
            "RELEASE_DATE",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.releaseDateLabel,
            "testReleaseDate",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.popularityTitleLabel,
            "POPULARITY",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.popularityLabel,
            123.0,
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.voteAverageTitleLabel,
            "VOTE_AVERAGE",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.voteAverageLabel,
            123.0,
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieListResponse?.movieArray.first?.identifier,
            34,
            "should match the data in the spy"
        )
    }
    func testFetchMovieListParsingFail() {
        // Given
        spyWorker.theResult = .parsingFail
        let request = MovieSummary.Success.Request()
        // When
        sut.fetchMovieList(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentErrorAlertCalled,
            "fetchMovieList with failure parsing should call presenter presentErrorAlert"
        )
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .service,
            "Error parsing should have a title Error"
        )
    }
    func testFetchMovieListGeneralFail() {
        // Given
        spyWorker.theResult = .failure
        let request = MovieSummary.Success.Request()
        // When
        sut.fetchMovieList(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentErrorAlertCalled,
            "fetchMovieList with failure should call presenter presentErrorAlert"
        )
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .internet,
            "Error in general should have a title Error"
        )
    }
    func testHandleDidSelectRow() {
        // Given
        let item = MovieSummaryResult.Result(
            popularity: 123,
            id: 34,
            title: "testTitle",
            voteAverage: 123,
            overview: "testOverview",
            releaseDate: "testReleaseDate"
        )
        let model = MovieSummaryResult(results: [item])
        sut.movieResult = model
        let request = MovieSummary.MovieDetail.Request(indexPath: 0)
        // When
        sut.handleDidSelectRow(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentSelectedMovieCalled,
            "handleDidSelectRow success should call presenter presentSelectedMovie"
        )
    }
}
