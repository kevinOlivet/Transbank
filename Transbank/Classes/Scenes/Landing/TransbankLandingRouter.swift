//
//  TransbankLandingRouter.swift
//  Pods
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

import UIKit

@objc
protocol TransbankLandingRoutingLogic {
    // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol TransbankLandingDataPassing {
    var dataStore: TransbankLandingDataStore? { get }
}

class TransbankLandingRouter: NSObject, TransbankLandingRoutingLogic, TransbankLandingDataPassing {
    weak var viewController: TransbankLandingViewController?
    var dataStore: TransbankLandingDataStore?

    // MARK: Routing

    // func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    // func navigateToSomewhere(source: TransbankLandingViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    // func passDataToSomewhere(source: TransbankLandingDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
