//
//  CosmicButton.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//

import SwiftUI

struct CosmicButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.8))
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [.gray, .white.opacity(0.5)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    }
                )
        }
    }
}
