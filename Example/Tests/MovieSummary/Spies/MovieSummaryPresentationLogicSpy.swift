//
//  MovieSummaryPresentationLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank

class MovieSummaryPresentationLogicSpy: MovieSummaryPresentationLogic {

    var presentSetupUICalled = false
    var presentLoadingViewCalled = false
    var presentHideLoadingViewCalled = false
    var presentErrorAlertCalled = false
    var presentMovieListCalled = false
    var presentSelectedMovieCalled = false

    var presentSetupUIResponse: MovieSummary.Texts.Response?
    var presentErrorAlertResponse: MovieSummary.Failure.Response?
    var presentMovieListResponse: MovieSummary.Success.Response?
    var presentSelectedMovieResponse: MovieSummary.MovieDetail.Response?

    func presentSetupUI(response: MovieSummary.Texts.Response) {
        presentSetupUICalled = true
        presentSetupUIResponse = response
    }
    func presentLoadingView() {
        presentLoadingViewCalled = true
    }
    func presentHideLoadingView() {
        presentHideLoadingViewCalled = true
    }
    func presentErrorAlert(response: MovieSummary.Failure.Response) {
        presentErrorAlertCalled = true
        presentErrorAlertResponse = response
    }
    func presentMovieList(response: MovieSummary.Success.Response) {
        presentMovieListCalled = true
        presentMovieListResponse = response
    }
    func presentSelectedMovie(response: MovieSummary.MovieDetail.Response) {
        presentSelectedMovieCalled = true
        presentSelectedMovieResponse = response
    }
}
