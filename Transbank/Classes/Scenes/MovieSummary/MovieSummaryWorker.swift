//
//  MovieSummaryWorker.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

import BasicCommons

class MovieSummaryWorker {

    var reachability: ReachabilityCheckingProtocol = Reachability()
    var repo: APITransbankProtocol = APITransbank()

    func getMovieList(
        page: String,
        successCompletion: @escaping (MovieSummaryResult?) -> Void,
        failureCompletion: @escaping (NTError) -> Void
    ) {
        guard reachability.isConnectedToNetwork() == true else {
            failureCompletion(NTError.noInternetConection)
            return
        }
        repo.getMovieSummary(
            page: page,
            success: { receivedMovies, _ in
                successCompletion(receivedMovies)
            }) { error, _ in
                failureCompletion(error)
            }
    }

}
