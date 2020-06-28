//
//  MovieDetailRoutingLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
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
