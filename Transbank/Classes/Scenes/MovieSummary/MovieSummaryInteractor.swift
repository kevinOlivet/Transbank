//
//  MovieSummaryInteractor.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import Foundation

protocol MovieSummaryBusinessLogic {
    func prepareSetUpUI(request: MovieSummary.Texts.Request)
    func fetchMovieList(request: MovieSummary.Success.Request)
    func handleDidSelectRow(request: MovieSummary.MovieDetail.Request)
}

protocol MovieSummaryDataStore {
    var selectedMovieName: String? { get set }
    var selectedMovieId: Int? { get set }
}

class MovieSummaryInteractor: MovieSummaryBusinessLogic, MovieSummaryDataStore {
    var presenter: MovieSummaryPresentationLogic?
    var worker: MovieSummaryWorker = MovieSummaryWorker()

    var movieResult: MovieSummaryResult?
    var selectedMovieName: String?
    var selectedMovieId: Int?

    // MARK: Methods

    func prepareSetUpUI(request: MovieSummary.Texts.Request) {
        let response = MovieSummary.Texts.Response(title: "SELECT_MOVIE")
        presenter?.presentSetupUI(response: response)
    }

    func fetchMovieList(request: MovieSummary.Success.Request) {
        presenter?.presentLoadingView()

        worker.getMovieList(successCompletion: { [weak self] (receivedMovies) in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.presentHideLoadingView()
            if let receivedMovies = receivedMovies {
                strongSelf.movieResult = receivedMovies
                let convertedMovies = receivedMovies.results.map {
                    MovieSummary.Success.Response.SingleMovieResponse(
                        titleLabel: $0.title,
                        releaseDateTitleLabel: "RELEASE_DATE",
                        releaseDateLabel: $0.releaseDate,
                        popularityTitleLabel: "POPULARITY",
                        popularityLabel: $0.popularity,
                        voteAverageTitleLabel: "VOTE_AVERAGE",
                        voteAverageLabel: $0.voteAverage,
                        identifier: $0.id
                    )
                }
                let response = MovieSummary.Success.Response(movieArray: convertedMovies)
                strongSelf.presenter?.presentMovieList(response: response)
            } else {
                let response = MovieSummary.Failure.Response(errorType: .service)
                strongSelf.presenter?.presentErrorAlert(response: response)
            }
        }) { (_) in
            self.presenter?.presentHideLoadingView()
            let response = MovieSummary.Failure.Response(errorType: .internet)
            self.presenter?.presentErrorAlert(response: response)
        }
    }

    func handleDidSelectRow(request: MovieSummary.MovieDetail.Request) {
        selectedMovieId = movieResult?.results[request.indexPath].id
        selectedMovieName = movieResult?.results[request.indexPath].title
        presenter?.presentSelectedMovie(response: MovieSummary.MovieDetail.Response())
    }
}
