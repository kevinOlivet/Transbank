//
//  MovieSummaryPresenter.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import UIKit

protocol MovieSummaryPresentationLogic {
    func presentSetupUI(response: MovieSummary.Texts.Response)
    func presentLoadingView()
    func presentHideLoadingView()
    func presentErrorAlert(response: MovieSummary.Failure.Response)
    func presentMovieList(response: MovieSummary.Success.Response)
    func presentSelectedMovie(response: MovieSummary.MovieDetail.Response)
}

class MovieSummaryPresenter: MovieSummaryPresentationLogic {
    weak  var viewController: MovieSummaryDisplayLogic?

    // MARK: Methods

    func presentSetupUI(response: MovieSummary.Texts.Response) {
        let viewModel = MovieSummary.Texts.ViewModel(title: response.title.localized)
        viewController?.displaySetupUI(viewModel: viewModel)
    }

    func presentLoadingView() {
        viewController?.displayLoadingView()
    }

    func presentHideLoadingView() {
        viewController?.hideLoadingView()
    }

    func presentErrorAlert(response: MovieSummary.Failure.Response) {
        let viewModel = MovieSummary.Failure.ViewModel(errorType: response.errorType)
        viewController?.displayErrorAlert(viewModel: viewModel)
    }

    func presentMovieList(response: MovieSummary.Success.Response) {
        let viewModelArray = response.movieArray.map {
            MovieSummary.Success.ViewModel.SingleMovieViewModel(
                titleLabel: $0.titleLabel,
                releaseDateTitleLabel: $0.releaseDateTitleLabel.localized,
                releaseDateLabel: $0.releaseDateLabel,
                popularityTitleLabel: $0.popularityTitleLabel.localized,
                popularityLabel: String($0.popularityLabel),
                voteAverageTitleLabel: $0.voteAverageTitleLabel.localized,
                voteAverageLabel: String($0.voteAverageLabel)
            )
        }
        let viewModel = MovieSummary.Success.ViewModel(movieArray: viewModelArray)
        viewController?.displayMovieArray(viewModel: viewModel)
    }

    func presentSelectedMovie(response: MovieSummary.MovieDetail.Response) {
        viewController?.showSelectedMovie(viewModel: MovieSummary.MovieDetail.ViewModel())
    }
}
