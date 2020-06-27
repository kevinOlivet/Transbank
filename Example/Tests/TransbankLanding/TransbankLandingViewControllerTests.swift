//
//  TransbankLandingViewControllerTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import XCTest

class TransbankLandingViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: TransbankLandingViewController!
    var spyInteractor: TransbankLandingBusinessLogicSpy!
    var spyRouter: TransbankLandingRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupTransbankLandingViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupTransbankLandingViewController() {
        sut = TransbankLandingViewController()

        spyInteractor = TransbankLandingBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = TransbankLandingRoutingLogicSpy()
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
            spyInteractor.setupUICalled,
            "viewDidLoad should call the interactor to setup the UI"
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
        sut = TransbankLandingViewController(coder: archiver)
        // Then
        XCTAssertNotNil(
            sut,
            "sut instantiated using the overrideInit"
        )
    }
    func testDisplaySetupUI() {
        // Given
        let viewModel = TransbankLanding.Basic.ViewModel(
            title: "testTitle",
            subtitle: "testSubtitle"
        )
        // When
        sut.displaySetupUI(viewModel: viewModel)
        // Then
        XCTAssertEqual(
            sut.titleLabelText,
            "testTitle",
            "should set the title correctly"
        )
        XCTAssertEqual(
            sut.subtitleLabelText,
            "testSubtitle",
            "should set the subtitle correctly"
        )
    }
    func testGoToTransbank() {
        // Given
        // When
        sut.goToTransbank()
        // Then
        XCTAssertTrue(
            spyRouter.routeToTransbankCalled,
            "goToTransbank should call router routeToTransbank"
        )
    }
}
