//
//  SongModel.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 20/06/25.
//

import Foundation

struct Song: Identifiable, Decodable,Equatable,Hashable {
    let id = UUID()
    let trackName: String
    let artistName: String
    let artworkUrl100: String
}
