//
//  MovieDetailRoutingLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import Foundation

class MovieDetailRoutingLogicSpy: NSObject, MovieDetailRoutingLogic, MovieDetailDataPassing {

    var dataStore: MovieDetailDataStore?

    var closeToDashboardCalled = false

    func closeToDashboard() {
        closeToDashboardCalled = true
    }
}
