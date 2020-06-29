//
//  TransbankLandingPresenter.swift
//  Pods
//
//  Copyright Kevin Olivet. All rights reserved.
//

import UIKit

protocol TransbankLandingPresentationLogic {
    func presentSetupUI(response: TransbankLanding.Basic.Response)
}

class TransbankLandingPresenter: TransbankLandingPresentationLogic {
    weak  var viewController: TransbankLandingDisplayLogic?

    // MARK: Methods

    func presentSetupUI(response: TransbankLanding.Basic.Response) {
        let viewModel = TransbankLanding.Basic.ViewModel(
            title: response.title.localized,
            subtitle: response.subtitle.localized
        )
        viewController?.displaySetupUI(viewModel: viewModel)
    }
}
