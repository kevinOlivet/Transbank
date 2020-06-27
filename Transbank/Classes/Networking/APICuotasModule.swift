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

    func getMovieSummary(success: @escaping (_ result: [MovieSummaryModel], Int) -> Void,
                         failure: @escaping (_ error: NTError, Int) -> Void)
}

class APITransbank: AuthenticatedAPI, APITransbankProtocol {

    // MARK: - Movie Summary
    func getMovieSummary(success: @escaping (_ result: [MovieSummaryModel], Int) -> Void,
                         failure: @escaping (_ error: NTError, Int) -> Void) {

        let url = Configuration.Api.movieSummary

        self.requestGeneric(
            type: [MovieSummaryModel].self,
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
}
