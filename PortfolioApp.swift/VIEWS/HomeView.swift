//
//  HomeView.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var appViewModel = AppViewModel() // Renamed for clarity
    
    @State private var animateArrow = false
    @State private var showPopAnimation = false
    
    // New state for appear animations
    @State private var showHeadline = false
    @State private var showSubheadline = false
    @State private var showDescription = false
    @State private var showViewWorkButton = false

    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Resume button (optional: also animate if you want)
                HStack {
                    CosmicButton(title: "Resume") {
                        print("Resume tapped")
                    }
                    .offset(y: 5)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                Spacer()
                
                // HEADLINE
                (Text("HEY, I'M ")
                    .foregroundColor(.black)
                 + Text("MAYUR")
                    .foregroundColor(.white)
                 + Text(" LAATE")
                    .foregroundColor(.black))
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    .opacity(showHeadline ? 1 : 0)
                    .offset(y: showHeadline ? 0 : 20)
                    .animation(.easeOut(duration: 0.8), value: showHeadline)
                
                // SUBHEADLINE
                (Text("iOS/APP ")
                    .foregroundColor(.white)
                 + Text("Developer")
                    .foregroundColor(.black))
                    .font(.system(size: 20, weight: .bold))
                    .opacity(showSubheadline ? 1 : 0)
                    .offset(y: showSubheadline ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.2), value: showSubheadline)
                
                // DESCRIPTION
                Text("I craft sleek and functional iOS apps using Swift and SwiftUI — focused on performance, design, and user experience.")
                    .foregroundStyle(.black)
                    .font(.system(size: 15, weight: .bold))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 0.1)
                    .opacity(showDescription ? 1 : 0)
                    .offset(y: showDescription ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: showDescription)
                
                // VIEW MY WORK BUTTON
                HStack {
                    Spacer()
                    
                    CosmicButton(title: "View My Work") {
                        // Pop effect on tap
                        withAnimation(.easeOut(duration: 0.2)) {
                            showPopAnimation = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            NotificationCenter.default.post(name: .scrollToProjects, object: nil)
                        }
                    }
                    .scaleEffect(showPopAnimation ? 1.1 : 1.0)
                    .onChange(of: showPopAnimation) { _ in
                        withAnimation(.easeIn(duration: 0.2)) {
                            showPopAnimation = false
                        }
                    }
                    .opacity(showViewWorkButton ? 1 : 0)
                    .offset(y: showViewWorkButton ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.6), value: showViewWorkButton)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 1)
                
                Spacer()
                
                // SCROLL DOWN ARROW
                Button(action: {
                    NotificationCenter.default.post(name: .scrollToAbout, object: nil)
                }) {
                    VStack(spacing: 4) {
                        Text("Scroll")
                            .foregroundColor(.white)
                            .font(.caption)
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                            .font(.title)
                            .offset(y: animateArrow ? 5 : -5)
                            .animation(
                                Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true),
                                value: animateArrow
                            )
                    }
                }
                .offset(y: 155)
                .onAppear {
                    animateArrow = true
                    
                    // Trigger appear animations in sequence
                    showHeadline = true
                    showSubheadline = true
                    showDescription = true
                    showViewWorkButton = true
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
