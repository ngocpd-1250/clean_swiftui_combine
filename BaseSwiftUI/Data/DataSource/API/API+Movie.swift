//
//  API+Movie.swift
//  clean_architechture
//
//  Created by phan.duong.ngoc on 2023/03/10.
//

import Foundation
import Alamofire

extension API {
    func getTopRatedMovies(_ input: GetTopRatedMoviesInput) -> Observable<GetTopRatedMoviesOutput> {
        return request(input)
    }

    func getUpcomingMovies(_ input: GetUpcomingMoviesInput) -> Observable<GetUpcomingMoviesOutput> {
        return request(input)
    }

    func getMovieDetail(_ input: GetMovieDetailInput) -> Observable<GetMovieDetailOutput> {
        return request(input)
    }
}

extension API {
    final class GetTopRatedMoviesInput: APIInput {
        init() {
            super.init(urlString: API.Urls.Movie.topRated,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: false)
        }
    }

    final class GetTopRatedMoviesOutput: APIOutput {
        private(set) var movies: [Movie] = []

        private enum CodingKeys: String, CodingKey {
            case movies = "results"
        }
    }
}

extension API {
    final class GetUpcomingMoviesInput: APIInput {
        init() {
            super.init(urlString: API.Urls.Movie.upcoming,
                       parameters: nil,
                       method: .get,
                       requireAccessToken: false)
        }
    }

    final class GetUpcomingMoviesOutput: APIOutput {
        private(set) var movies: [Movie] = []

        private enum CodingKeys: String, CodingKey {
            case movies = "results"
        }
    }
}

extension API {
    final class GetMovieDetailInput: APIInput {
        init(id: Int) {
            super.init(urlString: String(format: API.Urls.Movie.movieDetail, id),
                       parameters: nil,
                       method: .get,
                       requireAccessToken: false)
        }
    }

    final class GetMovieDetailOutput: APIOutput {
        private(set) var movie: Movie?

        required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            movie = try container.decode(Movie.self)
        }
    }
}
