//
//  MovieSummaryModel.swift
//  Transbank
//
//  Created by Kevin on 6/27/20.
//

import Foundation

struct MovieSummaryModel: Codable {
    let name: String
    let id: String
    let secureThumbnail: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case secureThumbnail = "secure_thumbnail"
    }
}
