//
//  TransbankLandingViewController.swift
//  Pods
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

import UIKit

protocol TransbankLandingDisplayLogic: AnyObject {
    //     func displaySomething(viewModel: TransbankLanding.Something.ViewModel)
}

class TransbankLandingViewController: UIViewController, TransbankLandingDisplayLogic {
    var interactor: TransbankLandingBusinessLogic?
    var router: (NSObjectProtocol & TransbankLandingRoutingLogic & TransbankLandingDataPassing)?

    //@IBOutlet weak var nameTextField: UITextField!

    // MARK: Object lifecycle

    override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = TransbankLandingInteractor()
        let presenter = TransbankLandingPresenter()
        let router = TransbankLandingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override  func viewDidLoad() {
        super.viewDidLoad()
//        doSomething()
    }

    // MARK: Methods

//     func doSomething() {
//        let request = TransbankLanding.Something.Request()
//        interactor?.doSomething(request: request)
//    }

//     func displaySomething(viewModel: TransbankLanding.Something.ViewModel) {
        //nameTextField.text = viewModel.name
//    }
}
