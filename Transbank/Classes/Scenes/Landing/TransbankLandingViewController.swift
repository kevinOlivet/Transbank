//
//  TransbankLandingViewController.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons
import BasicUIElements
import Lottie

protocol TransbankLandingDisplayLogic: AnyObject {
    func displaySetupUI(viewModel: TransbankLanding.Basic.ViewModel)
}

class TransbankLandingViewController: UIViewController, TransbankLandingDisplayLogic {
    var interactor: TransbankLandingBusinessLogic?
    var router: (NSObjectProtocol & TransbankLandingRoutingLogic & TransbankLandingDataPassing)?

    var animation: MainAnimationView?

    @IBOutlet private weak var welcomeView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    // MARK: Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    init() {
        let bundleToUse = Utils.bundle(forClass: TransbankLandingViewController.classForCoder())
        super.init(nibName: "TransbankLandingViewController", bundle: bundleToUse)
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

    // MARK: View lifecycle
    override  func viewDidLoad() {
        super.viewDidLoad()
        interactor?.setupUI(request: TransbankLanding.Basic.Request())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animation?.play()
    }

    // MARK: Methods
    func displaySetupUI(viewModel: TransbankLanding.Basic.ViewModel) {
        view.addTapAction(target: self, action: #selector(goToTransbank))
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        animation = WelcomeAnimation(
            width: welcomeView.frame.size.width,
            height: welcomeView.frame.size.height
        )
        welcomeView.addSubview(animation!)
    }

    @objc
    func goToTransbank() {
        router?.routeToTransbank()
    }

    // Getters
    var titleLabelText: String? { titleLabel.text }
    var subtitleLabelText: String? { subtitleLabel.text }
}
