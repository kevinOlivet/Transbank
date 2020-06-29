//
//  MovieDetailModels.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicUIElements

enum MovieDetail {

    enum Texts {
        struct Request {}
        struct Response {
            let title: String
        }
        struct ViewModel {
            let title: String
        }
    }

    enum Success {
        struct Request {}
        struct Response {
            let titleLabel: String
            let overviewLabel: String
            let budgetLabel: Int
            let revenueLabel: Int
            let homepageLabel: String
            let genreLabel: String?
            let productionCompanyLabel: String?
            let runtimeLabel: Int
        }
        struct ViewModel {
            let titleLabel: String
            let overviewLabel: String
            let budgetLabel: String
            let revenueLabel: String
            let homepageLabel: String
            let genreLabel: String
            let productionCompanyLabel: String
            let runtimeLabel: String
        }
    }

    enum Failure {
        struct Request {}
        struct Response {
            let errorType: FullScreenErrorType
        }
        struct ViewModel {
            let errorType: FullScreenErrorType
        }
    }
}
