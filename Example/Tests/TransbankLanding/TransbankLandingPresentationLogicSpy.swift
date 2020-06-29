//
//  TransbankLandingPresentationLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank

class TransbankLandingPresentationLogicSpy: TransbankLandingPresentationLogic {

    var presentSetupUICalled = false
    var presentSetupUIResponse: TransbankLanding.Basic.Response?

    func presentSetupUI(response: TransbankLanding.Basic.Response) {
        presentSetupUICalled = true
        presentSetupUIResponse = response
    }
}
