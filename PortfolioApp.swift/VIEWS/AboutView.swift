import SwiftUI

struct AboutView: View {
    let visible: Bool
    @State private var animationProgress: CGFloat = 0.0 // 0.0 to 1.0 for smooth progression
    @State private var hasAnimated = false // Track if animation has played

    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea() // Stable background

            VStack(alignment: .center, spacing: 24) {
                // Header
                (
                    Text("About ")
                        .foregroundColor(.white) +
                    Text("Me")
                        .foregroundColor(.black)
                )
                .font(.system(size: 36, weight: .bold))
                .multilineTextAlignment(.center)
                .opacity(animationProgress == 1.0 ? 1 : 0) // Fully opaque only at end
                .offset(y: (1 - animationProgress) * 20) // Move down from 0
                .animation(.easeOut(duration: 0.8), value: animationProgress)

                // Summary Text
                VStack(alignment: .leading, spacing: 12) {
                    Text("iOS Developer & Tech Creator | Building Scalable, User-Centric Apps")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
I am an iOS developer with over a year of hands-on experience in crafting responsive, accessible, and high-performance applications using Swift and SwiftUI. As a student at Delhi Technological University (DTU), New Delhi, I’ve successfully completed 2+ internships, gaining real-world experience in building and refining production-level iOS apps.

Driven by a strong passion for clean architecture and intuitive user experiences, I consistently stay aligned with the latest iOS trends, frameworks, and development best practices. I thrive on solving complex problems through efficient code and delivering impactful solutions that scale.
""")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .bold()
                }
                .padding(.horizontal)
                .opacity(animationProgress >= 0.25 ? 1 : 0) // Delay for summary
                .offset(y: (1 - min(animationProgress - 0.25, 1)) * 20)
                .animation(.easeOut(duration: 0.8).delay(0.2), value: animationProgress)

                // Buttons
                HStack(spacing: 8) { // Reduced spacing to bring buttons closer
                    Button(action: {
                        NotificationCenter.default.post(name: .scrollToContact, object: nil)
                    }) {
                        Text("Get In Touch")
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .offset(x: (1 - min(animationProgress - 0.5, 1)) * -30) // From left, closer distance
                    .opacity(animationProgress >= 0.5 ? 1 : 0)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: animationProgress)

                    Button(action: {
                        print("Download CV tapped")
                    }) {
                        Text("Download CV")
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .foregroundStyle(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    .offset(x: (1 - min(animationProgress - 0.5, 1)) * 30) // From right, closer distance
                    .opacity(animationProgress >= 0.5 ? 1 : 0)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: animationProgress)
                }
                .frame(maxWidth: .infinity, alignment: .center) // Center the HStack
                .padding(.top, 16)

                // Skills Section
                VStack(alignment: .leading, spacing: 20) {
                    Text("Skills")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    SkillCategoryView(title: "Languages", items: "Swift, SwiftUI, Java, Dart, Python")
                    SkillCategoryView(title: "Tools", items: "Xcode, Firebase, Postman, AWS, Git")
                    SkillCategoryView(title: "Concepts", items: "MVC, MVVM, REST APIs, Version Control, DSA")
                    SkillCategoryView(title: "Soft Skills", items: "Teamwork, Problem-solving, Attention to Detail")
                }
                .padding()
                .background(
                    Color.black.opacity(animationProgress >= 0.65 ? 0.2 : 0)
                        .cornerRadius(16)
                        .animation(.easeOut(duration: 0.6), value: animationProgress)
                )
                .opacity(animationProgress == 1.0 ? 1 : 0)
                .animation(.easeIn(duration: 0.8).delay(0.6), value: animationProgress)
                
            }
            .padding(.vertical, 40)
            .padding(.horizontal)
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
                // Force animation if already visible on appear
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

// MARK: - Reusable Skill Category View
struct SkillCategoryView: View {
    var title: String
    var items: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)

            Text(items)
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
