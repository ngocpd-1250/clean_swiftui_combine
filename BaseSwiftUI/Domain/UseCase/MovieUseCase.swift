//
//  MovieUseCase.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation
import Factory

protocol MovieUseCaseType {
    func getTopRatedMovies(page: Int) -> Observable<[Movie]>
    func getUpcomingMovies(page: Int) -> Observable<[Movie]>
    func getMovieDetail(id: Int) -> Observable<Movie?>
}

struct MovieUseCase: MovieUseCaseType {
    @Injected(\.movieRepository) private var movieRepository

    func getTopRatedMovies(page: Int) -> Observable<[Movie]> {
        return movieRepository.getTopRatedMovies(page: page)
    }

    func getUpcomingMovies(page: Int) -> Observable<[Movie]> {
        return movieRepository.getUpcomingMovies(page: page)
    }

    func getMovieDetail(id: Int) -> Observable<Movie?> {
        return movieRepository.getMovieDetail(id: id)
    }
}
