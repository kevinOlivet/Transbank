//
//  MovieSummaryCell.swift
//  Transbank
//
//  Created by Kevin Olivet on 6/27/20.
//

import UIKit

class MovieSummaryCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateTitleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var popularityTitleLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var voteAverageTitleLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!

    // MARK: - GettersSetters
    var objectVM: MovieSummary.Success.ViewModel.SingleMovieViewModel? {
        didSet {
            titleLabel.text = objectVM?.titleLabel
            releaseDateTitleLabel.text = objectVM?.releaseDateTitleLabel
            releaseDateLabel.text = objectVM?.releaseDateLabel
            popularityTitleLabel.text = objectVM?.popularityTitleLabel
            popularityLabel.text = objectVM?.popularityLabel
            voteAverageTitleLabel.text = objectVM?.voteAverageTitleLabel
            voteAverageLabel.text = objectVM?.voteAverageLabel
        }
    }
}
