//
//  APIUrls.swift
//  clean_architechture
//
//  Created by phan.duong.ngoc on 2023/03/10.
//

import Foundation

extension API {
    enum Urls {
        static var host = AppConfig.API.endPoint
        static var version = AppConfig.API.version
        static var baseUrl: String { return host / version }
    }
}

extension API.Urls {
    enum Movie {
        static var topRated: String { return baseUrl / "movie" / "top_rated" }
        static var upcoming: String { return baseUrl / "movie" / "upcoming" }
        static var movieDetail: String { return baseUrl / "movie" / "%d" }
    }
}
