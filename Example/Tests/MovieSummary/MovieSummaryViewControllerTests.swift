//
//  MovieSummaryViewControllerTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons
import BasicUIElements
@testable import Transbank
import XCTest

class MovieSummaryViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: MovieSummaryViewController!
    var spyInteractor: MovieSummaryBusinessLogicSpy!
    var spyRouter: MovieSummaryRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupMovieSummaryViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieSummaryViewController() {
        let bundle = Utils.bundle(forClass: MovieSummaryViewController.classForCoder())!
        let storyboard = UIStoryboard(name: "MoviesMain", bundle: bundle)
        sut = (
            storyboard.instantiateViewController(
                withIdentifier: "MovieSummaryViewController")
                as! MovieSummaryViewController
        )

        spyInteractor = MovieSummaryBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = MovieSummaryRoutingLogicSpy()
        sut.router = spyRouter

        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testViewDidLoad() {
        // Given
        // When
        // Then
        XCTAssertNotNil(
            sut,
            "the view should instantiate correctly"
        )
        XCTAssertTrue(
            spyInteractor.prepareSetUpUICalled,
            "viewDidLoad should call the interactor to setup the UI"
        )
        XCTAssertTrue(
            spyInteractor.fetchMovieListCalled,
            "viewDidLoad should call the interactor to fetch MovieList"
        )
    }
    func testRequiredInit() {
        // Given
        sut = nil
        XCTAssertNil(
            sut,
            "setting the sut to nil to test its other init"
        )
        // When
        let archiver = NSKeyedUnarchiver(forReadingWith: Data())
        sut = MovieSummaryViewController(coder: archiver)
        // Then
        XCTAssertNotNil(
            sut,
            "sut instantiated using the overrideInit"
        )
        XCTAssertTrue(
            spyInteractor.prepareSetUpUICalled,
            "viewDidLoad should call the interactor to setup the UI"
        )
        XCTAssertTrue(
            spyInteractor.fetchMovieListCalled,
            "viewDidLoad should call the interactor to fetchMovieList"
        )
    }
    func testDisplaySetupUI() {
        // Given
        let viewModel = MovieSummary.Texts.ViewModel(title: "testTitle")
        // When
        sut.displaySetupUI(viewModel: viewModel)
        // Then
        XCTAssertEqual(
            sut.titleText,
            "testTitle",
            "displaySetUpUI should set the title correctly"
        )
    }
    func testDisplayLoadingView() {
        // Given
        // When
        sut.displayLoadingView()
        // Then
        XCTAssertTrue(sut.view.subviews.last is MainActivityIndicator)
    }
    func testDisplayMovieArray() {
        // Given
        let item = MovieSummary.Success.ViewModel.SingleMovieViewModel(
            titleLabel: "titleLabelTest",
            releaseDateTitleLabel: "releaseDateTitleLabelTest",
            releaseDateLabel: "releaseDateLabelTest",
            popularityTitleLabel: "popularityTitleLabelTest",
            popularityLabel: "popularityLabelTest",
            voteAverageTitleLabel: "voteAverageTitleLabelTest",
            voteAverageLabel: "voteAverageLabelTest"
        )
        let viewModel = MovieSummary.Success.ViewModel(movieArray: [item])
        // When
        sut.displayMovieArray(viewModel: viewModel)
        // Then
        XCTAssertEqual(
            sut.moviesToDisplay.first?.titleLabel,
            viewModel.movieArray.first?.titleLabel, "should equal what is passed."
        )
        XCTAssertEqual(
            sut.moviesToDisplay.first?.releaseDateTitleLabel,
            viewModel.movieArray.first?.releaseDateTitleLabel, "should equal what is passed."
        )
        XCTAssertEqual(
            sut.moviesToDisplay.first?.releaseDateLabel,
            viewModel.movieArray.first?.releaseDateLabel, "should equal what is passed."
        )
        XCTAssertEqual(
            sut.moviesToDisplay.first?.popularityTitleLabel,
            viewModel.movieArray.first?.popularityTitleLabel, "should equal what is passed."
        )
        XCTAssertEqual(
            sut.moviesToDisplay.first?.popularityLabel,
            viewModel.movieArray.first?.popularityLabel, "should equal what is passed."
        )
        XCTAssertEqual(
            sut.moviesToDisplay.first?.voteAverageTitleLabel,
            viewModel.movieArray.first?.voteAverageTitleLabel, "should equal what is passed."
        )
        XCTAssertEqual(
            sut.moviesToDisplay.first?.voteAverageLabel,
            viewModel.movieArray.first?.voteAverageLabel, "should equal what is passed."
        )
    }
    func testDisplayErrorAlert() {
        // Given
        let viewModel = MovieSummary.Failure.ViewModel(errorType: .internet)
        // When
        sut.displayErrorAlert(viewModel: viewModel)
        // Then
        XCTAssertTrue(sut.view.subviews.last is FullScreenMessageErrorAnimated)
    }
    func testCloseButtonTapped() {
        // Given
        // When
        sut.closeButtonTapped()
        // Then
        XCTAssertTrue(spyRouter.closeToDashboardCalled)
    }
    func testShowSelectedMovie() {
        // Given
        let viewModel = MovieSummary.MovieDetail.ViewModel()
        // When
        sut.showSelectedMovie(viewModel: viewModel)
        // Then
        XCTAssertTrue(
            spyRouter.routeToMovieDetailCalled,
            "showSelectedMovie should call the routeToMovieDetail"
        )
    }
    func testCellForRow() {
        // Given
        let item = MovieSummary.Success.ViewModel.SingleMovieViewModel(
            titleLabel: "titleLabelTest",
            releaseDateTitleLabel: "releaseDateTitleLabelTest",
            releaseDateLabel: "releaseDateLabelTest",
            popularityTitleLabel: "popularityTitleLabelTest",
            popularityLabel: "popularityLabelTest",
            voteAverageTitleLabel: "voteAverageTitleLabelTest",
            voteAverageLabel: "voteAverageLabelTest"
        )
        sut.moviesToDisplay = [item]
        sut.getTableView.reloadData()
        let indexPathToUse = IndexPath(row: 0, section: 0)
        // When
        let cell = sut.tableView(sut.getTableView, cellForRowAt: indexPathToUse)
        XCTAssertTrue(cell is MovieSummaryCell, "cell should be MovieSummaryCell")
        guard let movieCell = cell as? MovieSummaryCell else {
            XCTFail("cell is not MovieSummaryCell")
            return
        }
        XCTAssertEqual(
            movieCell.objectVM?.titleLabel,
            "titleLabelTest",
            "should equal the name passed to the cell"
        )
        sut.tableView(sut.getTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(spyInteractor.handleDidSelectRowCalled)
    }
    func testDidSelectRow() {
        // Given
        let item = MovieSummary.Success.ViewModel.SingleMovieViewModel(
            titleLabel: "titleLabelTest",
            releaseDateTitleLabel: "releaseDateTitleLabelTest",
            releaseDateLabel: "releaseDateLabelTest",
            popularityTitleLabel: "popularityTitleLabelTest",
            popularityLabel: "popularityLabelTest",
            voteAverageTitleLabel: "voteAverageTitleLabelTest",
            voteAverageLabel: "voteAverageLabelTest"
        )
        sut.moviesToDisplay = [item]
        sut.getTableView.reloadData()
        let indexPathToUse = IndexPath(row: 0, section: 0)
        // When
        sut.tableView(sut.getTableView, didSelectRowAt: indexPathToUse)
        XCTAssertTrue(spyInteractor.handleDidSelectRowCalled)
        XCTAssertEqual(spyInteractor.handleDidSelectRowRequest?.indexPath, 0)
    }
}
