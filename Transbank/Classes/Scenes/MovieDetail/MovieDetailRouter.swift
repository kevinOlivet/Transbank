//
//  MovieDetailRouter.swift
//  Pods
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

import UIKit

@objc
protocol MovieDetailRoutingLogic {
    func closeToDashboard()
}

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouter: NSObject, MovieDetailRoutingLogic, MovieDetailDataPassing {
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?

    // MARK: Routing

    func closeToDashboard() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
