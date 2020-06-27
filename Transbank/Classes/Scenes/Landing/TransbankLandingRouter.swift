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
        print("Here routeToTransbank")
//        let storyboard = UIStoryboard(
//            name: "CuotasMain",
//            bundle: Utils.bundle(forClass: EnterAmountCleanViewController.classForCoder())
//        )
//        let destinationNVC = storyboard.instantiateInitialViewController() as! UINavigationController
//        destinationNVC.modalPresentationStyle = .fullScreen
//        navigateToTransbank(source: viewController!, destination: destinationNVC)
    }

    // MARK: Navigation
    func navigateToTransbank(source: TransbankLandingViewController, destination: UINavigationController) {
        source.present(destination, animated: true, completion: nil)
    }
}
