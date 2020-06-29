//
//  ConfigurationApiMs.swift
//  Transbank
//
//  Copyright © 2020 Jon Olivet. All rights reserved.
//

import BasicCommons

// MARK: - URL building
extension Configuration.Api {

    // MARK: - URL building

    private static var baseUrl: String { scheme + host }
    static var msUrl: String { baseUrl + basePath + branch }

    // MARK: - Base Paths

    private static var basePath: String {
        let config: String = Configuration.configurationForKeyAndSubKey(
            key: "Api",
            subKey: "basePath",
            baseConfigurationDictionary: baseConfigurationDictionary
        )
        return config
    }

    private static var branch: String {
        let config: String = Configuration.configurationForKeyAndSubKey(
            key: "Api",
            subKey: "branch",
            baseConfigurationDictionary: baseConfigurationDictionary
        )
        return config
    }

    static var baseConfigurationDictionary: [String: Any] {
        let baseConfigurationsResourcePath = Utils.bundle(forClass: TransbankFactory.self)!.url(
            forResource: "Transbank-Configuration",
            withExtension: "plist"
            )!

        do {
            guard let data = try? Foundation.Data(contentsOf: baseConfigurationsResourcePath),
                let result = try PropertyListSerialization.propertyList(
                    from: data,
                    options: [],
                    format: nil
                    ) as? [String: Any] else {
                        return [:]
            }
            return result
        } catch {
            return [:]
        }
    }

    static var movieSummary: String {
        let url = msUrl + Configuration.configurationForKeyAndSubKey(
            key: "Api",
            subKey: "API_MOVIE_SUMMARY",
            baseConfigurationDictionary: baseConfigurationDictionary
        )
        return url
    }

    static var movieDetail: String {
        let url = msUrl + Configuration.configurationForKeyAndSubKey(
            key: "Api",
            subKey: "API_MOVIE_DETAIL",
            baseConfigurationDictionary: baseConfigurationDictionary
        )
        return url
    }
}
