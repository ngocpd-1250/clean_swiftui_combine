//
//  MovieRepositoryImpl.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation
import Combine
import Factory

struct MovieRepositoryImpl: MovieRepository {
    func getTopRatedMovies(page _: Int) -> Observable<[Movie]> {
        let input = API.GetTopRatedMoviesInput()
        return API.shared.getTopRatedMovies(input)
            .map { $0.movies }
            .eraseToAnyPublisher()
    }

    func getUpcomingMovies(page _: Int) -> Observable<[Movie]> {
        let input = API.GetUpcomingMoviesInput()
        return API.shared.getUpcomingMovies(input)
            .map { $0.movies }
            .eraseToAnyPublisher()
    }

    func getMovieDetail(id: Int) -> Observable<Movie?> {
        let input = API.GetMovieDetailInput(id: id)
        return API.shared.getMovieDetail(input)
            .map { $0.movie }
            .eraseToAnyPublisher()
    }
}
