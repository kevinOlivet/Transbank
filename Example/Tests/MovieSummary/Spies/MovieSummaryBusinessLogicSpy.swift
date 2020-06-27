//
//  MovieSummaryBusinessLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

@testable import Transbank

class MovieSummaryBusinessLogicSpy: MovieSummaryBusinessLogic {

    var prepareSetUpUICalled = false
    var fetchMovieListCalled = false
    var handleDidSelectRowCalled = false

    var prepareSetUpUIRequest: MovieSummary.Texts.Request?
    var fetchMovieListRequest: MovieSummary.Success.Request?
    var handleDidSelectRowRequest: MovieSummary.MovieDetail.Request?

    func prepareSetUpUI(request: MovieSummary.Texts.Request) {
        prepareSetUpUICalled = true
        prepareSetUpUIRequest = request
    }
    func fetchMovieList(request: MovieSummary.Success.Request) {
        fetchMovieListCalled = true
        fetchMovieListRequest = request
    }
    func handleDidSelectRow(request: MovieSummary.MovieDetail.Request) {
        handleDidSelectRowCalled = true
        handleDidSelectRowRequest = request
    }
}
