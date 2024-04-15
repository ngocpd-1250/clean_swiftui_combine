//
//  LoadingView.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool

    var content: () -> Content

    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .center) {
                content()
                    .disabled(isShowing)
                ActivityIndicator(isAnimating: .constant(true), style: .large)
                    .frame(minWidth: 78,
                           idealWidth: nil,
                           maxWidth: nil,
                           minHeight: 78,
                           idealHeight: nil,
                           maxHeight: nil,
                           alignment: .center)
                    .background(Color(R.color.backgroundPrimary))
                    .cornerRadius(6)
                    .opacity(isShowing ? 1 : 0)
            }
        }
    }
}
