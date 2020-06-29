//
//  MovieSummaryModel.swift
//  Transbank
//
//  Created by Kevin on 6/27/20.
//

import Foundation

struct MovieSummaryResult: Codable {
    let page, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }

    // MARK: - Result
    struct Result: Codable {
        let popularity: Double
        let id: Int
        let title: String
        let voteAverage: Double
        let overview, releaseDate: String

        enum CodingKeys: String, CodingKey {
            case popularity
            case id
            case title
            case voteAverage = "vote_average"
            case overview
            case releaseDate = "release_date"
        }
    }
}
