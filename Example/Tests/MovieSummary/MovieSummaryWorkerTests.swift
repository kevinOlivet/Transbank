//
//  MovieSummaryWorkerTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons
import OHHTTPStubs
@testable import Transbank
import XCTest

class MovieSummaryWorkerTests: XCTestCase {
    // MARK: Subject under test

    var sut: MovieSummaryWorker!
    var reachabilitySpy: ReachabilityCheckingProtocol?
    let stubs = TransbankStubs(logging: true, verbose: true)

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupMovieSummaryWorker()
    }

    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieSummaryWorker() {
        sut = MovieSummaryWorker()
        stubs.removeAllStubs()
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: Tests
    func testGetMovieListSuccess() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.movieSummary,
            jsonFile: "GET_movie_summary_200.json",
            stubName: "Movie Summary stub",
            downloadSpeed: OHHTTPStubsDownloadSpeedWifi,
            responseTime: 0,
            replaceIfExists: false
        )

        let expectation = self.expectation(description: "calls the callback with a resource object")
        // When
        sut.getMovieList(successCompletion: { receivedMovies in
            // Then
            XCTAssertEqual(
                receivedMovies?.results.first?.title,
                "Ad Astra Test Data",
                "should match the JSON file"
            )
            XCTAssertEqual(
                receivedMovies?.results.first?.id,
                419704,
                "should match the JSON file"
            )
            XCTAssertEqual(
                receivedMovies?.results.first?.popularity,
                165.765,
                "should match the JSON file"
            )
            XCTAssertEqual(
                receivedMovies?.results.first?.releaseDate,
                "2019-09-17",
                "should match the JSON file"
            )
            XCTAssertEqual(
                receivedMovies?.results.first?.voteAverage,
                6.1,
                "should match the JSON file"
            )
            expectation.fulfill()
        }) { (_) in
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Movie Summary Stub")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetMovieListFail() {
        // Given
        stubs.registerStub(
            for: Configuration.Api.movieSummary,
            jsonFile: "GET_movie_summary_200.json",
            stubName: "Movie Summary Stub (general error)",
            responseTime: 1,
            failWithInternetError: true
        )
        let expectation = self.expectation(description: "network down")

        // When
        sut.getMovieList(successCompletion: { _ in
        }) { error in
            // Then
            XCTAssertNotNil(
                error,
                "no internet error returns an error"
            )
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
        stubs.removeStub(stubName: "Movie Summary Stub (general error)")
        OHHTTPStubs.removeAllStubs()
    }

    func testGetMovieListNoInternet() {
        // Given
        let reachabilitySpy = ReachabilitySpy()
        reachabilitySpy.isConnectedToNetworkReturnValue = false
        sut.reachability = reachabilitySpy

        let expectation = self.expectation(description: "network is down!")

        // When
        sut.getMovieList(successCompletion: { _ in
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
