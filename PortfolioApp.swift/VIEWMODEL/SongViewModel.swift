//
//  SongViewModel.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 20/06/25.
//

import Foundation
import Foundation

class SongViewModel: ObservableObject {
    @Published var songs: [Song] = []

    func fetchSongs(for query: String) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "pop"
        let urlString = "https://itunes.apple.com/search?term=\(encodedQuery)&entity=song&limit=1" // Limit to 1 to get the best match
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            if let result = try? JSONDecoder().decode(SearchResponse.self, from: data) {
                DispatchQueue.main.async {
                    if let song = result.results.first {
                        self.songs.append(song)
                    }
                }
            }
        }.resume()
    }
}

struct SearchResponse: Decodable {
    let results: [Song]
}

