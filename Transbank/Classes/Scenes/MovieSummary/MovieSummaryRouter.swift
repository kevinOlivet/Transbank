//
//  MovieSummaryRouter.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons

@objc
protocol MovieSummaryRoutingLogic {
    func closeToDashboard()
    func routeToMovieDetail()
}

protocol MovieSummaryDataPassing {
    var dataStore: MovieSummaryDataStore? { get }
}

class MovieSummaryRouter: NSObject, MovieSummaryRoutingLogic, MovieSummaryDataPassing {
    weak var viewController: MovieSummaryViewController?
    var dataStore: MovieSummaryDataStore?

    // MARK: Routing

    func closeToDashboard() {
        viewController?.navigationController?.dismiss(animated: true)
    }

    func routeToMovieDetail() {
        let storyboard = UIStoryboard(name: "MoviesMain", bundle: Utils.bundle(forClass: MovieDetailViewController.classForCoder()))
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        var destinationDS = destinationVC.router!.dataStore!

        passDataToBankSelect(source: dataStore!, destination: &destinationDS)
        navigateToBankSelect(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToBankSelect(source: MovieSummaryViewController, destination: MovieDetailViewController) {
        viewController?.navigationController?.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToBankSelect(source: MovieSummaryDataStore, destination: inout MovieDetailDataStore) {
        destination.selectedMovieId = source.selectedMovieId
        destination.selectedMovieName = source.selectedMovieName
    }
}
