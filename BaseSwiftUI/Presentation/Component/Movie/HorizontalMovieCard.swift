//
//  HorizontalMovieCard.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 23/04/2024.
//

import SwiftUI
import Kingfisher

private enum Constant {
    static let imageSize = CGSize(width: 150, height: 190)
}

struct HorizontalMovieCard: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let url = URL(string: movie.posterUrl) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constant.imageSize.width, height: Constant.imageSize.height)
                    .cornerRadius(10)
            }
            Text(movie.title)
                .foregroundStyle(Color(R.color.labelPrimary))
                .font(.headline)
                .lineLimit(1)
            HStack {
                Image(R.image.icon_rating)
                    .frame(width: 16, height: 16)
                Text("\(Int(movie.voteAverage))/10")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(R.color.orangeFlush))
            }
            Text("\(formatDate(movie.releaseDate))")
                .foregroundStyle(Color(R.color.labelPrimary))
                .font(.subheadline)
            Spacer()
        }
        .frame(width: Constant.imageSize.width)
    }
}
