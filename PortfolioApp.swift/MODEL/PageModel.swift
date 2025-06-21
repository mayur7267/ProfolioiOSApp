//
//  PageModel.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//

import Foundation
import SwiftUICore

struct PageModel: Identifiable {
    let id = UUID()
    let name: String
    let icon: String // SF Symbol name
    let sectionID: String // ID for scrolling
}
