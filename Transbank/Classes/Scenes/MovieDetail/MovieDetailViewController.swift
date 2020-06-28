//
//  MovieDetailViewController.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons
import BasicUIElements

protocol MovieDetailDisplayLogic: AnyObject {
    func displaySetupUI(viewModel: MovieDetail.Texts.ViewModel)
    func displayLoadingView()
    func hideLoadingView()
    func displayErrorAlert(viewModel: MovieDetail.Failure.ViewModel)
    func displayMovieDetail(viewModel: MovieDetail.Success.ViewModel)
}

class MovieDetailViewController: BaseViewController, MovieDetailDisplayLogic {
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var revenueLabel: UILabel!
    @IBOutlet private weak var homepageLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var productionCompanyLabel: UILabel!
    @IBOutlet private weak var runtimeLabel: UILabel!


    // MARK: Object lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
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
        interactor?.prepareSetUpUI(request: MovieDetail.Texts.Request())
        fetchMovieDetail()
    }

    // MARK: Methods
    @objc
    func fetchMovieDetail() {
        genericHideErrorView()
        interactor?.fetchMovieDetail(request: MovieDetail.Success.Request())
    }

    func displaySetupUI(viewModel: MovieDetail.Texts.ViewModel) {
        self.title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.stop,
            target: self,
            action: #selector(closeButtonTapped)
        )
    }

    @objc
    func closeButtonTapped() {
        genericHideErrorView()
        router?.closeToDashboard()
    }

    func displayLoadingView() {
        genericDisplayLoadingView()
    }

    func hideLoadingView() {
        genericHideLoadingView()
    }

    func displayMovieDetail(viewModel: MovieDetail.Success.ViewModel) {
        titleLabel.text = viewModel.titleLabel
        overviewLabel.text = viewModel.overviewLabel
        budgetLabel.text = viewModel.budgetLabel
        revenueLabel.text = viewModel.revenueLabel
        homepageLabel.text = viewModel.homepageLabel
        genreLabel.text = viewModel.genreLabel
        productionCompanyLabel.text = viewModel.productionCompanyLabel
        runtimeLabel.text = viewModel.runtimeLabel
    }

    func displayErrorAlert(viewModel: MovieDetail.Failure.ViewModel) {
        genericDisplayErrorView(
            typeOfError: viewModel.errorType,
            retryAction: #selector(fetchMovieDetail),
            closeAction: #selector(closeButtonTapped)
        )
    }

    // MARK: - GettersSetters
    var titleText: String? { self.title }
    var titleLabelText: String? { titleLabel.text }
    var overviewLabelText: String? { overviewLabel.text }
    var budgetLabelText: String? { budgetLabel.text }
    var revenueLabelText: String? { revenueLabel.text }
    var homepageLabelText: String? { homepageLabel.text }
    var genreLabelText: String? { genreLabel.text }
    var productionCompanyLabelText: String? { productionCompanyLabel.text }
    var runtimeLabelText: String? { runtimeLabel.text }
}
