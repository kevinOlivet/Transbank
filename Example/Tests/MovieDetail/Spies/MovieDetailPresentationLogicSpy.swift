//
//  MovieDetailPresentationLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank

class MovieDetailPresentationLogicSpy: MovieDetailPresentationLogic {

    var presentSetupUICalled = false
    var presentLoadingViewCalled = false
    var presentHideLoadingViewCalled = false
    var presentErrorAlertCalled = false
    var presentMovieDetailCalled = false

    var presentSetupUIResponse: MovieDetail.Texts.Response?
    var presentErrorAlertResponse: MovieDetail.Failure.Response?
    var presentMovieDetailResponse: MovieDetail.Success.Response?

    func presentSetupUI(response: MovieDetail.Texts.Response) {
        presentSetupUICalled = true
        presentSetupUIResponse = response
    }
    func presentLoadingView() {
        presentLoadingViewCalled = true
    }
    func presentHideLoadingView() {
        presentHideLoadingViewCalled = true
    }
    func presentErrorAlert(response: MovieDetail.Failure.Response) {
        presentErrorAlertCalled = true
        presentErrorAlertResponse = response
    }
    func presentMovieDetail(response: MovieDetail.Success.Response) {
        presentMovieDetailCalled = true
        presentMovieDetailResponse = response
    }
}
