//
//  ExperienceView.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//
import SwiftUI

struct ExperienceView: View {
    let visible: Bool
    @State private var animationProgress: CGFloat = 0.0 // 0.0 to 1.0 for smooth progression
    @State private var hasAnimated = false // Track if animation has played

    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Experience")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .opacity(animationProgress >= 0.25 ? 1 : 0) // Fade in with delay
                        .offset(y: (1 - min(animationProgress - 0.25, 1)) * 20) // Slide down
                        .animation(.easeOut(duration: 0.8).delay(0.2), value: animationProgress)

                    Text("*A journey through my professional roles, showcasing skills and achievements in iOS development and beyond.*")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .opacity(animationProgress >= 0.25 ? 1 : 0) // Fade in with delay
                        .offset(y: (1 - min(animationProgress - 0.25, 1)) * 20) // Slide down
                        .animation(.easeOut(duration: 0.8).delay(0.2), value: animationProgress)
                }
                .padding(.horizontal)

                // Experience Cards
                VStack(spacing: 20) {
                    ExperienceCardView(
                        imageName: "icon1",
                        role: "iOS Developer",
                        dateRange: "Nov 2024 – Jan 2024",
                        company: "TringBox",
                        details: """
• Developed a fully functional iOS app from scratch to meet company requirements.
Implemented APIs and Firebase. Optimized app performance and ensured smooth deployment on the App Store.
"""
                    )
                    .opacity(animationProgress >= 0.5 ? 1 : 0) // Fade in with delay
                    .offset(y: (1 - min(animationProgress - 0.5, 1)) * 20) // Slide up
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: animationProgress)

                    ExperienceCardView(
                        imageName: "icon2",
                        role: "iOS Developer",
                        dateRange: "Feb 2025 – June 2025",
                        company: "Trigrexam",
                        details: """
Identified and fixed key bugs, reducing crash rate by 40% across versions. Refactored major code modules for maintainability and performance. Contributed to deployment and QA testing via Xcode and App Store Connect.
"""
                    )
                    .opacity(animationProgress >= 0.75 ? 1 : 0) // Fade in with delay
                    .offset(y: (1 - min(animationProgress - 0.75, 1)) * 20) // Slide up
                    .animation(.easeOut(duration: 0.8).delay(0.6), value: animationProgress)
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 40)
            .onChange(of: visible) { newValue in
                if newValue && !hasAnimated {
                    withAnimation(.linear(duration: 0.8)) {
                        animationProgress = 1.0 // Drive all animations with a single progress value
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        hasAnimated = true
                    }
                }
            }
            .onAppear {
                animationProgress = 0.0 // Start with no progress
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
}

struct ExperienceCardView: View {
    var imageName: String
    var role: String
    var dateRange: String
    var company: String
    var details: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                Image(imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(8)

                VStack(alignment: .leading, spacing: 4) {
                    Text(role)
                        .font(.headline)
                        .foregroundColor(.white)

                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.subheadline)
                        Text(dateRange)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    Text(company)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                }
            }

            Text(details)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
    }
}

#Preview {
    ExperienceView(visible: true) // Preview with visible set to true for testing
}
