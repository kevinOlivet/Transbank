//
//  MovieSummaryDisplayLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank

class MovieSummaryDisplayLogicSpy: MovieSummaryDisplayLogic {

    var displaySetupUICalled = false
    var displayLoadingViewCalled = false
    var hideLoadingViewCalled = false
    var displayErrorAlertCalled = false
    var displayMovieArrayCalled = false
    var showSelectedMovieCalled = false

    var displaySetupUIViewModel: MovieSummary.Texts.ViewModel?
    var displayErrorAlertViewModel: MovieSummary.Failure.ViewModel?
    var displayMovieArrayViewModel: MovieSummary.Success.ViewModel?
    var showSelectedMovieViewModel: MovieSummary.MovieDetail.ViewModel?

    func displaySetupUI(viewModel: MovieSummary.Texts.ViewModel) {
        displaySetupUICalled = true
        displaySetupUIViewModel = viewModel
    }
    func displayLoadingView() {
        displayLoadingViewCalled = true
    }
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    func displayErrorAlert(viewModel: MovieSummary.Failure.ViewModel) {
        displayErrorAlertCalled = true
        displayErrorAlertViewModel = viewModel
    }
    func displayMovieArray(viewModel: MovieSummary.Success.ViewModel) {
        displayMovieArrayCalled = true
        displayMovieArrayViewModel = viewModel
    }
    func showSelectedMovie(viewModel: MovieSummary.MovieDetail.ViewModel) {
        showSelectedMovieCalled = true
        showSelectedMovieViewModel = viewModel
    }
}
