//
//  ProjectsView.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//

//import SwiftUI
//
//struct Project: Identifiable {
//    let id = UUID()
//    let title: String
//    let description: String
//    let tags: [String]
//}
//
//struct ProjectsView: View {
//    
//    let projects = [
//        Project(
//            title: "QR Code Scanner",
//            description: "A fully functional QR code scanning iOS app built from scratch using Swift and UIKit. It captures user data from QR codes and stores it locally with Core Data. Features include live camera scanning, dynamic result parsing, history logging, and a clean UI. Integrated Firebase with Apple Sign-In for secure authentication and external API handling. Successfully deployed to the App Store, demonstrating end-to-end iOS development skills.",
//            tags: ["Swift", "UIKit", "CoreData", "Firebase", "SwiftUI"]
//        ),
//        Project(
//            title: "Movie Explorer",
//            description: "A movie discovery app powered by the TMDB API. Users can explore trending and upcoming movies, view cast, ratings, trailers, and detailed descriptions. Built with Swift and SwiftUI, the app includes dynamic search, a clean UI, responsive layouts, and smooth API integration.",
//            tags: ["Swift", "SwiftUI", "TMDB API", "Asynchronous Networking"]
//        ),
//        Project(
//            title: "Lunar Legacy",
//            description: "An elegant SwiftUI-based iOS app that pays tribute to the Apollo missions. It fetches and displays curated content about each moon landing mission. Features include mission overviews, astronaut details, image galleries, and animated moon surface transitions.",
//            tags: ["SwiftUI", "API", "Animation", "Swift"]
//        ),
//        Project(
//            title: "MyPortfolio",
//            description: "A native iOS portfolio application built with Swift that showcases my development projects, skills, and professional experience through an intuitive mobile interface. The app features a clean, modern design with interactive project galleries, detailed technical descriptions, and integrated contact functionality.",
//            tags: ["Swift", "SwiftUI", "Portfolio", "iOS"]
//        )
//    ]
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                Text("Featured")
//                    .font(.system(size: 36, weight: .bold))
//                    .foregroundColor(.white)
//                + Text(" Projects")
//                    .font(.system(size: 36, weight: .bold))
//                    .foregroundColor(.black)
//                
//                Text("Here are some of my recent projects. Each project was carefully crafted with attention to detail, performance, and user experience.")
//                    .foregroundColor(.black)
//                    .padding(.bottom)
//                
//                ForEach(projects) { project in
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text(project.title)
//                            .font(.system(size: 26, weight: .bold))
//                            .foregroundColor(.white)
//                        Text(project.description)
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        HStack {
//                            ForEach(project.tags, id: \.self) { tag in
//                                Text(tag)
//                                    .font(.caption)
//                                    .padding(.horizontal, 10)
//                                    .padding(.vertical, 5)
//                                    .background(Color(.systemGray5))
//                                    .cornerRadius(10)
//                            }
//                        }
//                    }
//                    .padding()
//                    .background(Color(.black).opacity(0.6))
//                    .cornerRadius(20)
//                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
//                }
//            }
//            .padding()
//        }
//        .background(Color.gray.edgesIgnoringSafeArea(.all))
//    }
//}
//#Preview {
//    ProjectsView()
//}
import SwiftUI

struct Project: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let tags: [String]
}

struct ProjectsView: View {
    let visible: Bool
    @State private var animationProgress: CGFloat = 0.0
    @State private var hasAnimated = false
    @State private var tappedTag: String? = nil
    @State private var tappedCard: UUID? = nil

    let projects = [
        Project(
            title: "QR Code Scanner",
            description: "A fully functional QR code scanning iOS app built from scratch using Swift and UIKit. It captures user data from QR codes and stores it locally with Core Data. Features include live camera scanning, dynamic result parsing, history logging, and a clean UI. Integrated Firebase with Apple Sign-In for secure authentication and external API handling. Successfully deployed to the App Store, demonstrating end-to-end iOS development skills.Got 100+ downloads with a rating of ⭐️ 4.8.",
            tags: ["Swift", "UIKit", "CoreData", "Firebase", "SwiftUI"]
        ),
        Project(
            title: "Movie Explorer",
            description: "A movie discovery app powered by the TMDB API. Users can explore trending and upcoming movies, view cast, ratings, trailers, and detailed descriptions. Built with Swift and SwiftUI, the app includes dynamic search, a clean UI, responsive layouts, and smooth API integration.",
            tags: ["Swift", "SwiftUI", "TMDB API", "Asynchronous Networking"]
        ),
        Project(
            title: "Lunar Legacy",
            description: "An elegant SwiftUI-based iOS app that pays tribute to the Apollo missions. It fetches and displays curated content about each moon landing mission. Features include mission overviews, astronaut details, image galleries, and animated moon surface transitions.",
            tags: ["SwiftUI", "API", "Animation", "Swift"]
        ),
        Project(
            title: "MyPortfolio",
            description: "A native iOS portfolio application built with Swift that showcases my development projects, skills, and professional experience through an intuitive mobile interface. The app features a clean, modern design with interactive project galleries, detailed technical descriptions, and integrated contact functionality.",
            tags: ["Swift", "SwiftUI", "Portfolio", "iOS"]
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProjectHeader() // Removed animationProgress parameter
                    .padding(.bottom)

                ProjectListView(
                    projects: projects,
                    animationProgress: animationProgress,
                    tappedCard: $tappedCard,
                    tappedTag: $tappedTag
                )
            }
            .padding()
        }
        .background(Color.gray.opacity(0.8).edgesIgnoringSafeArea(.all))
        .onChange(of: visible) { newValue in
            if newValue && !hasAnimated {
                withAnimation(.linear(duration: 0.8)) {
                    animationProgress = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    hasAnimated = true
                }
            }
        }
        .onAppear {
            animationProgress = 0.0
            if visible {
                withAnimation(.linear(duration: 0.8)) {
                    animationProgress = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    hasAnimated = true
                }
            }
        }
    }
}

// Header View (No Animation)
struct ProjectHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Featured")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                Text(" Projects")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
            }

            Text("*Here are some of my recent projects. Each project was carefully crafted with attention to detail, performance, and user experience.*")
                .foregroundColor(.black)
        }
    }
}

// Project List View
struct ProjectListView: View {
    let projects: [Project]
    let animationProgress: CGFloat
    @Binding var tappedCard: UUID?
    @Binding var tappedTag: String?

    var body: some View {
        VStack(spacing: 20) {
            ForEach(projects) { project in
                ProjectCardView(
                    project: project,
                    animationProgress: animationProgress,
                    tappedCard: $tappedCard,
                    tappedTag: $tappedTag
                )
                .opacity(animationProgress >= 0.5 ? 1 : 0)
                .offset(y: (1 - min(animationProgress - 0.5, 1)) * 20)
                .animation(.easeOut(duration: 0.8).delay(project == projects.first ? 0.4 : 0.6), value: animationProgress)
            }
        }
    }
}

// Project Card View
struct ProjectCardView: View {
    let project: Project
    let animationProgress: CGFloat
    @Binding var tappedCard: UUID?
    @Binding var tappedTag: String?

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(project.title)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.black)
            Text(project.description)
                .font(.subheadline)
                .foregroundColor(.white)
            TagListView(
                tags: project.tags,
                tappedTag: $tappedTag
            )
        }
        .padding()
        .background(Color(.black).opacity(0.17))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .scaleEffect(tappedCard == project.id ? 1.05 : 1.0)
        .animation(.spring(response: 0.2, dampingFraction: 0.5), value: tappedCard)
        .onTapGesture {
            withAnimation {
                tappedCard = tappedCard == project.id ? nil : project.id
            }
        }
    }
}

// Tag List View
struct TagListView: View {
    let tags: [String]
    @Binding var tappedTag: String?

    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .scaleEffect(tappedTag == tag ? 1.1 : 1.0)
                    .animation(.spring(response: 0.2, dampingFraction: 0.5), value: tappedTag)
                    .onTapGesture {
                        withAnimation {
                            tappedTag = tappedTag == tag ? nil : tag
                        }
                    }
            }
        }
    }
}

#Preview {
    ProjectsView(visible: true)
}
