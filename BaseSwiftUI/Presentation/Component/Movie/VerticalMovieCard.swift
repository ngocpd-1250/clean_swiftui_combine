//
//  VerticalMovieCard.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 23/04/2024.
//

import SwiftUI
import Kingfisher

private enum Constant {
    static let imageSize = CGSize(width: 120, height: 165)
}

struct VerticalMovieCard: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let url = URL(string: movie.posterUrl) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constant.imageSize.width, height: Constant.imageSize.height)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color(R.color.labelPrimary))
                HStack {
                    Image(R.image.icon_rating)
                        .frame(width: 16, height: 16)
                    Text("\(Int(movie.voteAverage))/10")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(R.color.orangeFlush))
                }
                Text("\(formatDate(movie.releaseDate))")
                    .font(.subheadline)
                    .foregroundStyle(Color(R.color.labelPrimary))
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
