//
//  MoviesScreen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import SwiftUI
import Factory
import Defaults

struct MoviesScreen: View {
    @ObservedObject var input: MoviesViewModel.Input
    @ObservedObject var output: MoviesViewModel.Output

    private let cancelBag = CancelBag()
    private let toDetailTrigger = PublishRelay<Int>()
    private let loadTrigger = PublishRelay<Bool>()

    @ViewBuilder
    func nowPlayingMovies() -> some View {
        Section(title: R.string.localizable.movieNowPlaying()) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(output.data.nowPlaying) { movie in
                        Button {
                            toDetailTrigger.send(movie.id)
                        } label: {
                            HorizontalMovieCard(movie: movie)
                        }
                        .tint(.black)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func topRatedMovies() -> some View {
        Section(title: R.string.localizable.movieTopRated()) {
            ForEach(output.data.topRated) { movie in
                Button {
                    toDetailTrigger.send(movie.id)
                } label: {
                    VerticalMovieCard(movie: movie)
                }
                .tint(.black)
            }
        }
    }

    var body: some View {
        Screen(isLoading: $output.isLoading, localizeTitleResource: R.string.localizable.movieWatchTitle) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    nowPlayingMovies()
                    topRatedMovies()
                }
            }
            .padding(Spacing.normal.value)
            .refreshable {
                loadTrigger.send(true)
            }
        }
        .onAppear {
            loadTrigger.send(false)
        }
    }

    init(viewModel: MoviesViewModel) {
        let input = MoviesViewModel.Input(loadTrigger: loadTrigger.asDriver(),
                                          toDetailTrigger: toDetailTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
