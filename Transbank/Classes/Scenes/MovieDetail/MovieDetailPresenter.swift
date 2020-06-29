//
//  MovieDetailPresenter.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import UIKit

protocol MovieDetailPresentationLogic {
    func presentSetupUI(response: MovieDetail.Texts.Response)
    func presentLoadingView()
    func presentHideLoadingView()
    func presentErrorAlert(response: MovieDetail.Failure.Response)
    func presentMovieDetail(response: MovieDetail.Success.Response)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak  var viewController: MovieDetailDisplayLogic?

    // MARK: Methods

    func presentSetupUI(response: MovieDetail.Texts.Response) {
        let viewModel = MovieDetail.Texts.ViewModel(title: response.title.localized)
        viewController?.displaySetupUI(viewModel: viewModel)
    }

    func presentLoadingView() {
        viewController?.displayLoadingView()
    }

    func presentHideLoadingView() {
        viewController?.hideLoadingView()
    }

    func presentErrorAlert(response: MovieDetail.Failure.Response) {
        let viewModel = MovieDetail.Failure.ViewModel(errorType: response.errorType)
        viewController?.displayErrorAlert(viewModel: viewModel)
    }

    func presentMovieDetail(response: MovieDetail.Success.Response) {
        let viewModel = MovieDetail.Success.ViewModel(
            titleLabel: response.titleLabel.localized,
            overviewLabel: response.overviewLabel,
            budgetLabel: "BUDGET".localized + String(response.budgetLabel.displayAsCommaSeparated()),
            revenueLabel: "REVENUE".localized + String(response.revenueLabel.displayAsCommaSeparated()),
            homepageLabel: response.homepageLabel,
            genreLabel: response.genreLabel ?? "UNKNOWN_GENRE".localized,
            productionCompanyLabel: response.productionCompanyLabel ?? "UNKNOWN_COMPANY".localized,
            runtimeLabel: String(response.runtimeLabel) + "MINS".localized
        )
        viewController?.displayMovieDetail(viewModel: viewModel)
    }
}
