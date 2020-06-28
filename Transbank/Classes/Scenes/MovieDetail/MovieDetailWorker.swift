//
//  MovieDetailWorker.swift
//  Pods
//
//  Copyright © 2018 Banco de Crédito e Inversiones. All rights reserved.
//

import BasicCommons

class MovieDetailWorker {

    var reachability: ReachabilityCheckingProtocol = Reachability()
    var repo: APITransbankProtocol = APITransbank()

    func getMovieDetail(
        movieId: String,
        successCompletion: @escaping (MovieDetailResult?) -> Void,
        failureCompletion: @escaping (NTError) -> Void
    ) {
        guard reachability.isConnectedToNetwork() == true else {
            failureCompletion(NTError.noInternetConection)
            return
        }
        repo.getMovieDetail(
            movieId: movieId,
            success: { receivedDetail, _ in
                successCompletion(receivedDetail)
            }) { error, _ in
                failureCompletion(error)
            }
    }
}
