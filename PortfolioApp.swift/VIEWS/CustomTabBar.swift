//
//  CustomTabBar.swift
//  PortfolioApp
//
//  Created by Mayur on 19/06/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let pages: [PageModel]
    let scrollProxy: ScrollViewProxy

    var body: some View {
        HStack(spacing: 20){
            ForEach(0..<pages.count, id: \.self) { index in
                TabItemView(
                    icon: pages[index].icon,
                    name: pages[index].name,
                    isSelected: selectedTab == index
                ) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = index
                        scrollProxy.scrollTo(pages[index].sectionID, anchor: .top)
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 30)
        .background(
            // Glass-like blur effect
            BlurView(style: .systemUltraThinMaterialDark)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                )
        )
        .padding(.horizontal, 10)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
    }
}


struct TabItemView: View {
    let icon: String
    let name: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .renderingMode(.template)
                    .font(.system(size: 20, weight: .medium))
                    .frame(width: 30, height: 30)
                Text(name)
                    .font(.caption2)
            }
            .foregroundColor(isSelected ? .black : .white)
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}


#Preview {
    ContentView()
}
