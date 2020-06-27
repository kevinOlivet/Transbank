//
//  APITransbank.swift
//  Transbank
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Alamofire
import BasicCommons

protocol APITransbankProtocol {

    func getMovieSummary(success: @escaping (_ result: MovieSummaryResult, Int) -> Void,
                         failure: @escaping (_ error: NTError, Int) -> Void)
}

class APITransbank: AuthenticatedAPI, APITransbankProtocol {

    // MARK: - Movie Summary
    func getMovieSummary(success: @escaping (_ result: MovieSummaryResult, Int) -> Void,
                         failure: @escaping (_ error: NTError, Int) -> Void) {

        let url = Configuration.Api.movieSummary

        self.requestGeneric(
            type: MovieSummaryResult.self,
            url: url,
            method: HTTPMethod.get,
            parameters: nil,
            encoding: JSONEncoding.default,
            validStatusCodes: [Int](200..<300),
            onSuccess: { movieSummaryModel, _, statusCode in
                success(movieSummaryModel!, statusCode!)
            }, onFailure: { error, statusCode in
                failure(error, statusCode)
            }
        )
    }

    class func formatGetDetailResource(_ resource: String, _ path: String) -> String {
        let instancedResource = resource.replacingOccurrences(of: "{movie_id}", with: path)
        return instancedResource
    }
}
