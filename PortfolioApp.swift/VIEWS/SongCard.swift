//
//  SongCard.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 20/06/25.
//
import SwiftUI

struct SongCardView: View {
    let song: Song
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: song.artworkUrl100)) { phase in
                switch phase {
                case .empty:
                    Color.gray
                        .frame(width: 140, height: 140)
                        .cornerRadius(12)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipped()
                        .cornerRadius(12)
                case .failure(_):
                    Color.red
                        .frame(width: 140, height: 140)
                        .cornerRadius(12)
                @unknown default:
                    EmptyView()
                }
            }

            Text(song.artistName)
                .font(.caption)
                .foregroundColor(.white)
                .lineLimit(1) // Limit to one line to maintain height consistency

            Text(song.trackName)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1) // Limit to one line to maintain height consistency
        }
        .frame(width: 140, height: 180) // Fixed height to ensure uniform size
        .onTapGesture {
            onTap()
        }
    }
}
