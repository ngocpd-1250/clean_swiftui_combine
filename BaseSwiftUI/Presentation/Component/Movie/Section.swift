//
//  Section.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 23/04/2024.
//

import SwiftUI

struct Section<Content: View>: View {
    let title: String
    let content: () -> Content
    var moreAction: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .fontWeight(.semibold)
                    .font(.title2)
                    .foregroundStyle(Color(R.color.labelPrimary))

                Spacer()

                Button(R.string.localizable.commonSeeMore(), action: moreAction)
                    .tint(Color(R.color.labelPrimary))
            }
            content()
        }
    }
}
