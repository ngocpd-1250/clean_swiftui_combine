//
//  MovieDetailViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 23/04/2024.
//

import Foundation
import Factory
import Combine
import Defaults

struct MovieDetailViewModel {
    let navigator: MovieDetailNavigatorType
    let id: Int
    @Injected(\.movieUseCase) private var movieUseCase
}

// MARK: - ViewModelType
extension MovieDetailViewModel: ViewModel {
    final class Input: ObservableObject {
        let loadTrigger: Driver<Bool>

        init(loadTrigger: Driver<Bool>) {
            self.loadTrigger = loadTrigger
        }
    }

    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var isReloading = false
        @Published var movie: Movie?
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let activityTracker = ActivityTracker()
        let reloadActivityTracker = ActivityTracker()
        let errorTracker = ErrorTracker()

        input.loadTrigger
            .map { isReload in
                self.movieUseCase.getMovieDetail(id: id)
                    .trackError(errorTracker)
                    .trackActivity(isReload ? reloadActivityTracker : activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .assign(to: \.movie, on: output)
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

        return output
    }
}
