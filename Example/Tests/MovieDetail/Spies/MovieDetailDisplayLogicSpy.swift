//
//  MovieDetailDisplayLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import Transbank

class MovieDetailDisplayLogicSpy: MovieDetailDisplayLogic {

    var displaySetupUICalled = false
    var displayLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var displayErrorAlertCalled = false
    var displayMovieDetailCalled = false

    var displaySetupUIViewModel: MovieDetail.Texts.ViewModel?
    var displayErrorAlertViewModel: MovieDetail.Failure.ViewModel?
    var displayMovieDetailViewModel: MovieDetail.Success.ViewModel?

    func displaySetupUI(viewModel: MovieDetail.Texts.ViewModel) {
        displaySetupUICalled = true
        displaySetupUIViewModel = viewModel
    }
    func displayLoadingView() {
        displayLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func displayErrorAlert(viewModel: MovieDetail.Failure.ViewModel) {
        displayErrorAlertCalled = true
        displayErrorAlertViewModel = viewModel
    }
    func displayMovieDetail(viewModel: MovieDetail.Success.ViewModel) {
        displayMovieDetailCalled = true
        displayMovieDetailViewModel = viewModel
    }
}
