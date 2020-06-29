//
//  MovieSummaryRoutingLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import Foundation

class MovieSummaryRoutingLogicSpy: NSObject, MovieSummaryRoutingLogic, MovieSummaryDataPassing {

    var dataStore: MovieSummaryDataStore?

    var closeToDashboardCalled = false
    var routeToMovieDetailCalled = false

    func closeToDashboard() {
        closeToDashboardCalled = true
    }
    func routeToMovieDetail() {
        routeToMovieDetailCalled = true
    }
}
