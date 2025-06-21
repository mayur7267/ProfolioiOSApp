//
//  SongSectionView.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 20/06/25.
//

import SwiftUI

struct SongSectionView: View {
    @StateObject private var viewModel = SongViewModel()
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("*A few songs I’d personally recommend if you’re looking to refresh your playlist;)*")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal)

            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.songs.indices, id: \.self) { index in
                            // Use your existing SongCardView here
                            SongCardView(song: viewModel.songs[index]) {
                                if let url = viewModel.getiTunesURL(for: viewModel.songs[index]) {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .onReceive(timer) { _ in
                    guard !viewModel.songs.isEmpty else { return }
                    withAnimation {
                        currentIndex = (currentIndex + 1) % viewModel.songs.count
                        proxy.scrollTo(currentIndex, anchor: .center)
                    }
                }
            }
        }
        .onAppear {
            let songQueries = [
                "Photograph Ed Sheeran",
                "Sunsetz Cigarettes After Sex",
                "Ordinary Alex Warren",
                "Somewhere Only We Know Keane",
                "Night Changes One Direction",
                "The Night We Met Lord Huron",
                "Perfect Ed Sheeran",
                "Blue Young Kai",
                "End of Beginning Djo"
            ]
            for query in songQueries {
                viewModel.fetchSongs(for: query)
            }
        }
    }
}

extension SongViewModel {
    func getiTunesURL(for song: Song) -> URL? {
        let searchQuery = "\(song.trackName) \(song.artistName)"
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string: "https://music.apple.com/us/search?term=\(encodedQuery ?? "")")
    }
}

#Preview{
    ContentView()
}
