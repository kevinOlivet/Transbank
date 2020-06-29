//
//  TransbankLandingBusinessLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank

class TransbankLandingBusinessLogicSpy: TransbankLandingBusinessLogic {
    
    var setupUICalled = false
    var setupUIRequest: TransbankLanding.Basic.Request?
    
    func setupUI(request: TransbankLanding.Basic.Request) {
        setupUICalled = true
        setupUIRequest = request
    }
}
