//
//  OnboardingScreen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 16/04/2024.
//

import SwiftUI

struct OnboardingScreen: View {
    @ObservedObject var input: OnboardingViewModel.Input
    @ObservedObject var output: OnboardingViewModel.Output

    private let cancelBag = CancelBag()
    private let setIsDoneOnboarding = PublishRelay<Void>()

    @State var selectedPage = 0
    private var pages = OnboardingPage.allCases
    private var isLastPage: Bool {
        return selectedPage == pages.count - 1
    }

    var body: some View {
        Screen {
            TabView(selection: $selectedPage) {
                ForEach(pages.indices, id: \.self) { index in
                    page(pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .navigationBarHidden(true)
        }
    }

    @ViewBuilder
    func page(_ page: OnboardingPage) -> some View {
        VStack {
            page.image
                .padding(.vertical, Spacing.small.value)

            Text(page.title)
                .font(.title)
                .foregroundStyle(Color(R.color.labelPrimary))

            Text(page.description)
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(R.color.labelPrimary))

            if isLastPage {
                BaseButton(title: R.string.localizable.onboardingGetStarted()) {
                    setIsDoneOnboarding.send(())
                }
                .frame(width: 240, height: 52)
                .padding(.top, Spacing.normal.value)
            }
        }
        .padding(Spacing.normal.value)
    }

    init(viewModel: OnboardingViewModel) {
        let input = OnboardingViewModel.Input(setIsDoneOnboarding: setIsDoneOnboarding.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
