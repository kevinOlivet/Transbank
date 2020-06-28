//
//  MovieDetailWorkerTests.swift
//  Transbank
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

import BasicCommons
import OHHTTPStubs
@testable import Transbank
import XCTest

class MovieDetailWorkerTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieDetailWorker!
    var reachabilitySpy: ReachabilityCheckingProtocol?
    let stubs = TransbankStubs(logging: true, verbose: true)

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieDetailWorker()
    }

    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailWorker() {
        sut = MovieDetailWorker()
        stubs.removeAllStubs()
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: Tests
    func testGetMovieDetailSuccess() {
        // Given
        stubs.registerStub(
            for: APITransbank.formatGetDetailResource(Configuration.Api.movieDetail, "419704"),
            jsonFile: "GET_movie_detail_200.json",
            stubName: "Movie Detail stub",
            downloadSpeed: OHHTTPStubsDownloadSpeedWifi,
            responseTime: 0,
            replaceIfExists: false
        )

        let expectation = self.expectation(description: "calls the callback with a resource object")
        // When
        sut.getMovieDetail(movieId: "419704", successCompletion: { movieDetailResult in
            // Then
            XCTAssertEqual(
                movieDetailResult?.title,
                "Ad Astra Test Data",
                "should match the JSON file"
            )
            XCTAssertEqual(
                movieDetailResult?.id,
                419704,
                "should match the JSON file"
            )
            XCTAssertEqual(
                movieDetailResult?.popularity,
                165.765,
                "should match the JSON file"
            )
            XCTAssertEqual(
                movieDetailResult?.releaseDate,
                "2019-09-17",
                "should match the JSON file"
            )
            XCTAssertEqual(
                movieDetailResult?.voteAverage,
                6.1,
                "should match the JSON file"
            )
            expectation.fulfill()
        }) { (_) in
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Movie Detail Stub")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetMovieDetailFail() {
        // Given
        stubs.registerStub(
            for: APITransbank.formatGetDetailResource(Configuration.Api.movieDetail, "419704"),
            jsonFile: "GET_movie_detail_200.json",
            stubName: "Movie Detail Stub (general error)",
            responseTime: 1,
            failWithInternetError: true
        )
        let expectation = self.expectation(description: "network down")

        // When
        sut.getMovieDetail(
            movieId: "419704",
            successCompletion: { _ in
        }) { (error) in
            // Then
            XCTAssertNotNil(
                error,
                "no internet error returns an error"
            )
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Movie Detail Stub (general error)")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetMovieDetailNoInternet() {
        // Given
        let reachabilitySpy = ReachabilitySpy()
        reachabilitySpy.isConnectedToNetworkReturnValue = false
        sut.reachability = reachabilitySpy

        let expectation = self.expectation(description: "network is down!")

        // When
        sut.getMovieDetail(
            movieId: "419704",
            successCompletion: { (_) in
        }) { error in
            switch error {
            case NTError.noInternetConection:
                expectation.fulfill()
                return

            default:
                return
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }
}
