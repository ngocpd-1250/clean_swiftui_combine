//
//  MoviesViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation
import Factory
import Combine

struct MoviesViewModel {
    let navigator: MoviesNavigatorType
    @Injected(\.movieUseCase) private var movieUseCase
}

// MARK: - ViewModelType
extension MoviesViewModel: ViewModel {
    struct MoviesData {
        var topRated: [Movie] = []
        var nowPlaying: [Movie] = []
    }

    final class Input: ObservableObject {
        let loadTrigger: Driver<Bool>
        let toDetailTrigger: Driver<Int>

        init(loadTrigger: Driver<Bool>,
             toDetailTrigger: Driver<Int>) {
            self.loadTrigger = loadTrigger
            self.toDetailTrigger = toDetailTrigger
        }
    }

    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var topRatedMovies: [Movie] = []
        @Published var nowPlayingMovies: [Movie] = []
        @Published var data = MoviesData()
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker()
        let reloadActivityTracker = ActivityTracker()
        let output = Output()

        let nowPlaying = input.loadTrigger
            .map { isReload in
                self.movieUseCase.getNowPlayingMovies(page: 1)
                    .trackError(errorTracker)
                    .trackActivity(isReload ? reloadActivityTracker : activityTracker)
                    .asDriver()
            }
            .switchToLatest()

        let topRated = input.loadTrigger
            .map { isReload in
                self.movieUseCase.getTopRatedMovies(page: 1)
                    .trackError(errorTracker)
                    .trackActivity(isReload ? reloadActivityTracker : activityTracker)
                    .asDriver()
            }
            .switchToLatest()

        Publishers.Zip(nowPlaying, topRated)
            .map {
                MoviesData(topRated: $0.0, nowPlaying: $0.1)
            }
            .assign(to: \.data, on: output)
            .cancel(with: cancelBag)

        activityTracker.isLoading
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .cancel(with: cancelBag)

        reloadActivityTracker.isLoading
            .receive(on: RunLoop.main)
            .assign(to: \.isReloading, on: output)
            .cancel(with: cancelBag)

        errorTracker
            .receive(on: RunLoop.main)
            .unwrap()
            .sink(receiveValue: { error in
                navigator.showError(message: error.localizedDescription)
            })
            .cancel(with: cancelBag)

        input.toDetailTrigger
            .sink(receiveValue: navigator.toMovieDetail(id:))
            .cancel(with: cancelBag)

        return output
    }
}
