//
//  MovieDetailInteractorTests.swift
//  Transbank
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

import BasicCommons
@testable import Transbank
import XCTest

class MovieDetailInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieDetailInteractor!
    var spyPresenter: MovieDetailPresentationLogicSpy!
    var spyWorker: MovieDetailWorkerSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieDetailInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        spyWorker = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailInteractor() {
        sut = MovieDetailInteractor()
        sut.selectedMovieId = 419704

        spyPresenter = MovieDetailPresentationLogicSpy()
        sut.presenter = spyPresenter

        spyWorker = MovieDetailWorkerSpy()
        sut.worker = spyWorker
    }

    // MARK: Test doubles

    enum PossibleResults {
        case success
        case parsingFail
        case failure
    }

    class MovieDetailWorkerSpy: MovieDetailWorker {

        var theResult: PossibleResults = .success
        var getMovieDetailCalled = false

        override func getMovieDetail(
            movieId: String,
            successCompletion: @escaping (MovieDetailResult?) -> Void,
            failureCompletion: @escaping (NTError) -> Void
        ) {
            getMovieDetailCalled = true

            switch theResult {
            case .success:

                let genre = MovieDetailResult.Genre(name: "testGenre")
                let company = MovieDetailResult.ProductionCompany(name: "testCompany")
                let model = MovieDetailResult(
                    budget: 123,
                    genres: [genre],
                    homepage: "testhomepage",
                    id: 45,
                    overview: "testoverview",
                    popularity: 67,
                    posterPath: "testposterPath",
                    productionCompanies: [company],
                    releaseDate: "testreleaseDate",
                    revenue: 89,
                    runtime: 12,
                    title: "testtitle",
                    voteAverage: 345
                )
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
        let request = MovieDetail.Texts.Request()
        // When
        sut.prepareSetUpUI(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentSetupUICalled,
            "prepareSetUpUI should ask the presenter to format the result"
        )
        XCTAssertEqual(
            spyPresenter.presentSetupUIResponse?.title,
            "MOV_DEETS",
            "should match the data"
        )
    }
    func testFetchMovieDetailSuccess() {
        // Given
        spyWorker.theResult = .success
        let request = MovieDetail.Success.Request()
        // When
        sut.fetchMovieDetail(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentMovieDetailCalled,
            "fetchPaymentMethods with success should call presenter presentPaymentMethods"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.titleLabel,
            "testtitle",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.overviewLabel,
            "testoverview",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.budgetLabel,
            123,
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.revenueLabel,
            89,
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.homepageLabel,
            "testhomepage",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.genreLabel,
            "testGenre",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.productionCompanyLabel,
            "testCompany",
            "should match the data in the spy"
        )
        XCTAssertEqual(
            spyPresenter.presentMovieDetailResponse?.runtimeLabel,
            12,
            "should match the data in the spy"
        )
    }
    func testFetchMovieDetailParsingFail() {
        // Given
        spyWorker.theResult = .parsingFail
        let request = MovieDetail.Success.Request()
        // When
        sut.fetchMovieDetail(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentErrorAlertCalled,
            "fetchMovieDetail with failure parsing should call presenter presentErrorAlert"
        )
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .service,
            "Error parsing should have a title Error"
        )
    }
    func testFetchMovieDetailGeneralFail() {
        // Given
        spyWorker.theResult = .failure
        let request = MovieDetail.Success.Request()
        // When
        sut.fetchMovieDetail(request: request)
        // Then
        XCTAssertTrue(
            spyPresenter.presentErrorAlertCalled,
            "fetchMovieDetail with failure should call presenter presentErrorAlert"
        )
        XCTAssertEqual(
            spyPresenter.presentErrorAlertResponse?.errorType,
            .internet,
            "Error in general should have a title Error"
        )
    }
}
