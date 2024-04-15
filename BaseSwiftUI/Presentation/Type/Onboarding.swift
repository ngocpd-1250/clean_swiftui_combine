//
//  Onboarding.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 25/04/2024.
//

import SwiftUI

enum OnboardingPage: CaseIterable {
    case page1
    case page2
    case page3

    var image: Image {
        switch self {
        case .page1:
            return Image(R.image.onboarding_page1)
        case .page2:
            return Image(R.image.onboarding_page2)
        case .page3:
            return Image(R.image.onboarding_page3)
        }
    }

    var title: String {
        switch self {
        case .page1:
            return R.string.localizable.onboardingPage1Title()
        case .page2:
            return R.string.localizable.onboardingPage2Title()
        case .page3:
            return R.string.localizable.onboardingPage3Title()
        }
    }

    var description: String {
        switch self {
        case .page1:
            return R.string.localizable.onboardingPage1Description()
        case .page2:
            return R.string.localizable.onboardingPage2Description()
        case .page3:
            return R.string.localizable.onboardingPage3Description()
        }
    }
}
