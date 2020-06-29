//
//  TransbankLandingWorkerTests.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank
import XCTest

class TransbankLandingWorkerTests: XCTestCase {
    // MARK: Subject under test

    var sut: TransbankLandingWorker!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupTransbankLandingWorker()
    }

    override  func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupTransbankLandingWorker() {
        sut = TransbankLandingWorker()
    }

    // MARK: Tests
    // nothing to test here yet
}
