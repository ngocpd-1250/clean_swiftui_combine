//
//  VScroll.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 16/04/2024.
//

import SwiftUI

struct VScrollView<Content>: View where Content: View {
    @ViewBuilder let content: Content

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                content
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
            }
        }
    }
}
