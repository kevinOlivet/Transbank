//
//  MovieSummaryModels.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicUIElements

enum MovieSummary {

    // MARK: Use cases

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
            let movieArray: [SingleMovieResponse]
            struct SingleMovieResponse {
                let titleLabel: String
                let releaseDateTitleLabel: String
                let releaseDateLabel: String
                let popularityTitleLabel: String
                let popularityLabel: Double
                let voteAverageTitleLabel: String
                let voteAverageLabel: Double
                let identifier: Int
            }
        }
        struct ViewModel {
            let movieArray: [SingleMovieViewModel]
            struct SingleMovieViewModel {
                let titleLabel: String
                let releaseDateTitleLabel: String
                let releaseDateLabel: String
                let popularityTitleLabel: String
                let popularityLabel: String
                let voteAverageTitleLabel: String
                let voteAverageLabel: String
            }
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

    enum MovieDetail {
        struct Request {
            let indexPath: Int
        }
        struct Response {}
        struct ViewModel {}
    }

    enum Cell: CGFloat {
        case height = 150
    }
}
