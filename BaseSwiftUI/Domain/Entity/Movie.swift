//
//  Movie.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation
import Then

struct Movie: Identifiable {
    var id: Int
    var adult = false
    var title = ""
    var overview = ""
    var popularity = 0.0
    var posterPath = ""
    var backdropPath = ""
    var voteCount = 0
    var voteAverage = 0.0
    var video = false
    var releaseDate = ""

    var posterUrl: String {
        return AppConfig.MovieDB.imageUrl / posterPath
    }

    var backdropUrl: String {
        return AppConfig.MovieDB.imageUrl / backdropPath
    }
}

extension Movie: Then, Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }

    init() {
        self.init(id: 0)
    }
}

extension Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, adult, title, overview, popularity, video
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
