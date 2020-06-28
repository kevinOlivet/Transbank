//
//  MovieDetailViewControllerTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons
import BasicUIElements
@testable import Transbank
import XCTest

class MovieDetailViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: MovieDetailViewController!
    var spyInteractor: MovieDetailBusinessLogicSpy!
    var spyRouter: MovieDetailRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupMovieDetailViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupMovieDetailViewController() {
        let bundle = Utils.bundle(forClass: MovieDetailViewController.classForCoder())!
        let storyboard = UIStoryboard(name: "MoviesMain", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController)

        spyInteractor = MovieDetailBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = MovieDetailRoutingLogicSpy()
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
            spyInteractor.fetchMovieDetailCalled,
            "viewDidLoad should call the interactor to fetchMovieDetail"
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
        sut = MovieDetailViewController(coder: archiver)
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
            spyInteractor.fetchMovieDetailCalled,
            "viewDidLoad should call the interactor to fetchMovieDetail"
        )
    }
    func testDisplaySetupUI() {
        // Given
        let viewModel = MovieDetail.Texts.ViewModel(title: "testTitle")
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
    func testDisplayMovieDetail() {
        // Given
        let viewModel = MovieDetail.Success.ViewModel(
            titleLabel: "testtitleLabel",
            overviewLabel: "testoverviewLabel",
            budgetLabel: "testbudgetLabel",
            revenueLabel: "testrevenueLabel",
            homepageLabel: "testhomepageLabel",
            genreLabel: "testgenreLabel",
            productionCompanyLabel: "testproductionCompanyLabel",
            runtimeLabel: "testruntimeLabel"
        )
        // When
        sut.displayMovieDetail(viewModel: viewModel)
        // Then
        XCTAssertEqual(
            sut.titleLabelText,
            "testtitleLabel",
            "should equal what is passed."
        )
        XCTAssertEqual(
            sut.overviewLabelText,
            "testoverviewLabel",
            "should equal what is passed."
        )
        XCTAssertEqual(
            sut.budgetLabelText,
            "testbudgetLabel",
            "should equal what is passed."
        )
        XCTAssertEqual(
            sut.revenueLabelText,
            "testrevenueLabel",
            "should equal what is passed."
        )
        XCTAssertEqual(
            sut.homepageLabelText,
            "testhomepageLabel",
            "should equal what is passed."
        )
        XCTAssertEqual(
            sut.genreLabelText,
            "testgenreLabel",
            "should equal what is passed."
        )
        XCTAssertEqual(
            sut.productionCompanyLabelText,
            "testproductionCompanyLabel",
            "should equal what is passed."
        )
        XCTAssertEqual(
            sut.runtimeLabelText,
            "testruntimeLabel",
            "should equal what is passed."
        )
    }
    func testDisplayErrorAlert() {
        // Given
        let viewModel = MovieDetail.Failure.ViewModel(errorType: .internet)
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
}
