//
//  MovieDetailScreen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 23/04/2024.
//

import SwiftUI
import Kingfisher

struct MovieDetailScreen: View {
    @ObservedObject var input: MovieDetailViewModel.Input
    @ObservedObject var output: MovieDetailViewModel.Output

    private let cancelBag = CancelBag()
    private let loadTrigger = PublishRelay<Bool>()

    @ViewBuilder
    func backdrop(movie: Movie) -> some View {
        ZStack(alignment: .bottom) {
            if let url = URL(string: movie.backdropUrl) {
                VStack(alignment: .leading) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 210)
                        .frame(maxWidth: .infinity)

                    Spacer()
                        .frame(height: 40)
                }
            }
            if let url = URL(string: movie.posterUrl) {
                HStack(alignment: .bottom) {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 120)
                        .cornerRadius(8)

                    Spacer()
                }
                .padding(.horizontal, Spacing.normal.value)
            }
        }
    }

    @ViewBuilder
    func info(movie: Movie) -> some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(R.image.icon_rating)
                        .frame(width: 16, height: 16)
                    Text("\(Int(movie.voteAverage))/10")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(R.color.orangeFlush))
                }

                Text("\(R.string.localizable.movieRelease()): \(formatDate(movie.releaseDate))")
                    .fontWeight(.bold)

                    .foregroundStyle(Color(R.color.labelPrimary))

                Text("\(movie.overview)")
                    .padding(.top, Spacing.small.value)
                    .foregroundStyle(Color(R.color.labelPrimary))
            }
            .padding(.horizontal, Spacing.normal.value)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var body: some View {
        Screen(isLoading: $output.isLoading, title: output.movie?.title) {
            ScrollView {
                Group {
                    if let movie = output.movie {
                        VStack(spacing: 16) {
                            backdrop(movie: movie)
                            info(movie: movie)
                        }
                    } else {
                        VStack {}
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .refreshable {
                loadTrigger.send(true)
            }
        }
        .onAppear {
            loadTrigger.send(false)
        }
    }

    init(viewModel: MovieDetailViewModel) {
        let input = MovieDetailViewModel.Input(loadTrigger: loadTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
