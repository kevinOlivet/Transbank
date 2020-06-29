//
//  MovieDetailInteractor.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import Foundation

protocol MovieDetailBusinessLogic {
    func prepareSetUpUI(request: MovieDetail.Texts.Request)
    func fetchMovieDetail(request: MovieDetail.Success.Request)
}

protocol MovieDetailDataStore {
    var selectedMovieName: String? { get set }
    var selectedMovieId: Int? { get set }
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {

    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker = MovieDetailWorker()

    var selectedMovieName: String?
    var selectedMovieId: Int?
    var movieDetailResult: MovieDetailResult?

    // MARK: Methods
    func prepareSetUpUI(request: MovieDetail.Texts.Request) {
        let response = MovieDetail.Texts.Response(title: "MOV_DEETS")
        presenter?.presentSetupUI(response: response)
    }

    func fetchMovieDetail(request: MovieDetail.Success.Request) {
        guard let selectedMovieId = selectedMovieId else { return }
        presenter?.presentLoadingView()

        worker.getMovieDetail(
            movieId: String(selectedMovieId),
            successCompletion: { [weak self] receivedDetail in

                guard let strongSelf = self else { return }
                strongSelf.presenter?.presentHideLoadingView()
                if let receivedDetail = receivedDetail {
                    strongSelf.movieDetailResult = receivedDetail
                    let response = MovieDetail.Success.Response(
                        titleLabel: receivedDetail.title,
                        overviewLabel: receivedDetail.overview,
                        budgetLabel: receivedDetail.budget,
                        revenueLabel: receivedDetail.revenue,
                        homepageLabel: receivedDetail.homepage,
                        genreLabel: receivedDetail.genres.first?.name,
                        productionCompanyLabel: receivedDetail.productionCompanies.first?.name,
                        runtimeLabel: receivedDetail.runtime
                    )
                    strongSelf.presenter?.presentMovieDetail(response: response)
                } else {
                    let response = MovieDetail.Failure.Response(errorType: .service)
                    strongSelf.presenter?.presentErrorAlert(response: response)
                }
        }) { (_) in
            self.presenter?.presentHideLoadingView()
            let response = MovieDetail.Failure.Response(errorType: .internet)
            self.presenter?.presentErrorAlert(response: response)
        }
    }
}
