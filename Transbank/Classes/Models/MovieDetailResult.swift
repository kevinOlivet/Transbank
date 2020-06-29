//
//  MovieDetailResult.swift
//  Transbank
//
//  Created by Kevin Olivet on 6/27/20.
//

import Foundation

struct MovieDetailResult: Codable {
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let releaseDate: String
    let revenue, runtime: Int
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case budget, genres, homepage, id
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case revenue, runtime
        case title
        case voteAverage = "vote_average"
    }
    // MARK: - Genre
    struct Genre: Codable {
        let name: String
    }

    // MARK: - ProductionCompany
    struct ProductionCompany: Codable {
        let name: String

        enum CodingKeys: String, CodingKey {
            case name
        }
    }
}
