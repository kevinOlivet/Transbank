//
//  MovieDetailBusinessLogicSpy.swift
//  Transbank
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import Transbank

class MovieDetailBusinessLogicSpy: MovieDetailBusinessLogic {

    var prepareSetUpUICalled = false
    var fetchMovieDetailCalled = false

    var prepareSetUpUIRequest: MovieDetail.Texts.Request?
    var fetchMovieDetailRequest: MovieDetail.Success.Request?

    func prepareSetUpUI(request: MovieDetail.Texts.Request) {
        prepareSetUpUICalled = true
        prepareSetUpUIRequest = request
    }
    func fetchMovieDetail(request: MovieDetail.Success.Request) {
        fetchMovieDetailCalled = true
        fetchMovieDetailRequest = request
    }
}
