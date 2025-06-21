//
//  AppViewModel.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    
    let pages: [PageModel] = [
        PageModel(name: "Home", icon: "house", sectionID: "home"),
        PageModel(name: "About", icon: "person", sectionID: "about"),
        PageModel(name: "Experience", icon: "briefcase", sectionID: "experience"),
        PageModel(name: "Projects", icon: "folder", sectionID: "projects"),
        PageModel(name: "Contact", icon: "envelope", sectionID: "contact")
    ]
}
