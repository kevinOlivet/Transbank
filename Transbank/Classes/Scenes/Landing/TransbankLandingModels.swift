//
//  TransbankLandingModels.swift
//  Pods
//
//  Copyright © 2018 Kevin Olivet. All rights reserved.
//

enum TransbankLanding {

    enum Basic {
        struct Request { }
        struct Response {
            let title: String
            let subtitle: String
        }
        struct ViewModel {
            let title: String
            let subtitle: String
        }
    }
}
