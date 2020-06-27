//
//  TransbankLandingInteractor.swift
//  Pods
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

import Foundation

protocol TransbankLandingBusinessLogic {
//    func doSomething(request: TransbankLanding.Something.Request)
}

protocol TransbankLandingDataStore {
    //var name: String { get set }
}

class TransbankLandingInteractor: TransbankLandingBusinessLogic, TransbankLandingDataStore {
    var presenter: TransbankLandingPresentationLogic?
    var worker: TransbankLandingWorker = TransbankLandingWorker()
    // var name: String = ""

    // MARK: Methods

//     func doSomething(request: TransbankLanding.Something.Request) {
//        worker.doSomeWork()
//
//        let response = TransbankLanding.Something.Response()
//        presenter?.presentSomething(response: response)
//    }
}
