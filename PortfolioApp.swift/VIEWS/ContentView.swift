//
//  ContentView.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AppViewModel()
    @State private var visibleSection: String? = nil // Initialize with nil, update dynamically

    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack(alignment: .bottom) {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .center, spacing: 24) { // Using VStack for consistent rendering
                        HomeView()
                            .frame(minHeight: UIScreen.main.bounds.height * 0.6)
                            .id("home")
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: VisibleSectionPreferenceKey.self, value: [VisibleSection(id: "home", frame: geometry.frame(in: .global))])
                                    // Debug frame
                                    // print("HomeView frame: \(geometry.frame(in: .global))")
                                }
                            )

                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer(minLength: 35)
                        
                        AboutView(visible: visibleSection == "about")
                            .frame(minHeight: UIScreen.main.bounds.height * 0.4)
                            .id("about")
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: VisibleSectionPreferenceKey.self, value: [VisibleSection(id: "about", frame: geometry.frame(in: .global))])
                                    // Debug frame
                                   
                                }
                            )

                        ExperienceView(visible: visibleSection == "experience")
                            .frame(minHeight: UIScreen.main.bounds.height * 0.2)
                            .id("experience")
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: VisibleSectionPreferenceKey.self, value: [VisibleSection(id: "experience", frame: geometry.frame(in: .global))])
                                }
                            )
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()

                        ProjectsView(visible: visibleSection == "projects") // Pass visible parameter
                            .frame(minHeight: UIScreen.main.bounds.height * 0.4)
                            .id("projects")
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: VisibleSectionPreferenceKey.self, value: [VisibleSection(id: "projects", frame: geometry.frame(in: .global))])
                                }
                            )
                        
                        SongSectionView()
                            .frame(minHeight: UIScreen.main.bounds.height * 0.4)
                            .id("")
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: VisibleSectionPreferenceKey.self, value: [VisibleSection(id: "", frame: geometry.frame(in: .global))])
                                }
                            )

                        ContactView()
                            .frame(minHeight: UIScreen.main.bounds.height * 0.4)
                            .id("contact")
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: VisibleSectionPreferenceKey.self, value: [VisibleSection(id: "contact", frame: geometry.frame(in: .global))])
                                }
                            )
                    }
                    .background(Color.gray)
                }

                CustomTabBar(
                    selectedTab: $viewModel.selectedTab,
                    pages: viewModel.pages,
                    scrollProxy: scrollProxy
                )
                .padding(.bottom, 1)
            }
            .onPreferenceChange(VisibleSectionPreferenceKey.self) { sections in
                let screenHeight = UIScreen.main.bounds.height
                let visibleSections = sections.filter { $0.frame.minY <= screenHeight && $0.frame.minY >= -screenHeight / 2 } // Trigger when top is near screen
                if let visible = visibleSections.first?.id {
                    visibleSection = visible
                    // Debug to confirm trigger
                    print("Visible section set to: \(visible), frame: \(visibleSections.first?.frame)")
                } else if visibleSection != nil {
                    // Keep the last visible section to avoid resetting
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .scrollToAbout)) { _ in
                withAnimation(.easeInOut(duration: 0.6)) {
                    scrollProxy.scrollTo("about", anchor: .top)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .scrollToProjects)) { _ in
                withAnimation(.easeInOut(duration: 0.6)) {
                    scrollProxy.scrollTo("projects", anchor: .top)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .scrollToContact)) { _ in
                withAnimation(.easeInOut(duration: 0.6)) {
                    scrollProxy.scrollTo("contact", anchor: .top)
                }
            }
        }
    }
}

struct VisibleSection: Equatable {
    let id: String
    let frame: CGRect
}

struct VisibleSectionPreferenceKey: PreferenceKey {
    static var defaultValue: [VisibleSection] = []
    
    static func reduce(value: inout [VisibleSection], nextValue: () -> [VisibleSection]) {
        value.append(contentsOf: nextValue())
    }
}

extension Notification.Name {
    static let scrollToAbout = Notification.Name("scrollToAbout")
    static let scrollToProjects = Notification.Name("scrollToProjects")
    static let scrollToContact = Notification.Name("scrollToContact")
}

#Preview {
    ContentView()
}
