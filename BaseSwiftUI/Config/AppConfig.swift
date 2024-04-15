//
//  AppConfig.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation

enum AppConfig {
    enum API {
        static var endPoint: String {
            return infoForKey("API_ENDPOINT")
        }

        static var version: String {
            return infoForKey("API_VERSION")
        }
    }

    enum MovieDB {
        static var apiKey: String {
            return "000be3fbe452a9afe32f314596801204"
        }

        static var imageUrl: String {
            return "https://image.tmdb.org/t/p/w500"
        }
    }
}
