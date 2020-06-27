//
//  TransbankLandingDisplayLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank

class TransbankLandingDisplayLogicSpy: TransbankLandingDisplayLogic {
    
    var displaySetupUICalled = false
    var displaySetupUIViewModel: TransbankLanding.Basic.ViewModel?
    
    func displaySetupUI(viewModel: TransbankLanding.Basic.ViewModel) {
        displaySetupUICalled = true
        displaySetupUIViewModel = viewModel
    }
}
