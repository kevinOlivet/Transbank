//
//  MovieSummaryViewController.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons
import BasicUIElements

protocol MovieSummaryDisplayLogic: AnyObject {
    func displaySetupUI(viewModel: MovieSummary.Texts.ViewModel)
    func displayLoadingView()
    func hideLoadingView()
    func displayErrorAlert(viewModel: MovieSummary.Failure.ViewModel)
    func displayMovieArray(viewModel: MovieSummary.Success.ViewModel)
    func showSelectedMovie(viewModel: MovieSummary.MovieDetail.ViewModel)
}

public class MovieSummaryViewController: BaseViewController, MovieSummaryDisplayLogic {
    var interactor: MovieSummaryBusinessLogic?
    var router: (NSObjectProtocol & MovieSummaryRoutingLogic & MovieSummaryDataPassing)?

    var moviesToDisplay: [MovieSummary.Success.ViewModel.SingleMovieViewModel] = []

    @IBOutlet weak var tableView: UITableView!

    // MARK: Object lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = MovieSummaryInteractor()
        let presenter = MovieSummaryPresenter()
        let router = MovieSummaryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }


    // MARK: View lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor?.prepareSetUpUI(request: MovieSummary.Texts.Request())
        fetchMovieList()
    }

    // MARK: Methods
    @objc
    func fetchMovieList() {
        genericHideErrorView()
        interactor?.fetchMovieList(request: MovieSummary.Success.Request())
    }

    func displaySetupUI(viewModel: MovieSummary.Texts.ViewModel) {
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

    func displayMovieArray(viewModel: MovieSummary.Success.ViewModel) {
        moviesToDisplay.append(contentsOf: viewModel.movieArray)
        tableView.reloadData()
    }

    func displayErrorAlert(viewModel: MovieSummary.Failure.ViewModel) {
        genericDisplayErrorView(
            typeOfError: viewModel.errorType,
            retryAction: #selector(fetchMovieList),
            closeAction: #selector(closeButtonTapped)
        )
    }

    func showSelectedMovie(viewModel: MovieSummary.MovieDetail.ViewModel) {
        router?.routeToMovieDetail()
    }
}

extension MovieSummaryViewController: UITableViewDataSource, UITableViewDelegate {

    private static let cellIdentifier = "MovieSummaryCell"
    private func setupTableView() {
        let cellIdentifier = type(of: self).cellIdentifier
        let bundle = Utils.bundle(forClass: type(of: self).classForCoder())
        let nib = UINib(nibName: cellIdentifier, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.reloadData()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesToDisplay.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: type(of: self).cellIdentifier,
            for: indexPath
            ) as! MovieSummaryCell
        let movie = moviesToDisplay[indexPath.row]
        cell.objectVM = movie
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = MovieSummary.MovieDetail.Request(indexPath: indexPath.row)
        interactor?.handleDidSelectRow(request: request)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MovieSummary.Cell.height.rawValue
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == moviesToDisplay.count - 5 else { return }
        fetchMovieList()
    }

    // MARK: - GettersSetters
    var titleText: String? { self.title }
    var getTableView: UITableView { tableView }
}
