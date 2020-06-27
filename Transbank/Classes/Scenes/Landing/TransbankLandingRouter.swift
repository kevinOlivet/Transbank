//
//  TransbankLandingRouter.swift
//  Pods
//
//  Copyright © Kevin Olivet. All rights reserved.
//

import BasicCommons

@objc
protocol TransbankLandingRoutingLogic {
    func routeToTransbank()
}

protocol TransbankLandingDataPassing {
    var dataStore: TransbankLandingDataStore? { get }
}

class TransbankLandingRouter: NSObject, TransbankLandingRoutingLogic, TransbankLandingDataPassing {
    weak var viewController: TransbankLandingViewController?
    var dataStore: TransbankLandingDataStore?

    // MARK: Routing

    func routeToTransbank() {
        let storyboard = UIStoryboard(
            name: "MoviesMain",
            bundle: Utils.bundle(forClass: MovieSummaryViewController.classForCoder())
        )
        let destinationNVC = storyboard.instantiateInitialViewController() as! UINavigationController
        destinationNVC.modalPresentationStyle = .fullScreen
        navigateToTransbank(source: viewController!, destination: destinationNVC)
    }

    // MARK: Navigation
    func navigateToTransbank(source: TransbankLandingViewController, destination: UINavigationController) {
        source.present(destination, animated: true, completion: nil)
    }
}
