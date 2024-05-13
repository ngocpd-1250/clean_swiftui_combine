//
//  MovieRepository.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation

protocol MovieRepository {
    func getTopRatedMovies(page: Int) -> Observable<[Movie]>
    func getUpcomingMovies(page: Int) -> Observable<[Movie]>
    func getMovieDetail(id: Int) -> Observable<Movie?>
}
