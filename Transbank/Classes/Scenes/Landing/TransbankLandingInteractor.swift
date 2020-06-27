//
//  TransbankLandingInteractor.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import Foundation

protocol TransbankLandingBusinessLogic {
    func setupUI(request: TransbankLanding.Basic.Request)
}

protocol TransbankLandingDataStore {}

class TransbankLandingInteractor: TransbankLandingBusinessLogic, TransbankLandingDataStore {
    var presenter: TransbankLandingPresentationLogic?
    var worker: TransbankLandingWorker = TransbankLandingWorker()
    
    // MARK: Methods

    func setupUI(request: TransbankLanding.Basic.Request) {
        let response = TransbankLanding.Basic.Response(
            title: "WELCOME_TITLE",
            subtitle: "WELCOME_SUBTITLE"
        )
        presenter?.presentSetupUI(response: response)
    }
}
