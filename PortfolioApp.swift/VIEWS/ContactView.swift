//
//  ContactView.swift
//  PortfolioApp.swift
//
//  Created by Mayur on 19/06/25.
//

import SwiftUI

struct ContactView: View {
    // MARK: - Properties
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
                    Text("Get In ")
                        .font(.system(size: 40, weight: .bold)) +
                    Text("Touch")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.black)

                    Text("*Have a project in mind or want to collaborate? Feel free to reach out. I'm always open to discussing new opportunities.*")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal,1)
                }
                .padding(.top, 50)

                // Contact Info
                VStack(alignment: .leading, spacing: 2) {
                    Text("Contact Information")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.black)

                    ContactRow(icon: "envelope.fill", text: "mayurl.7267@gmail.com")
                    ContactRow(icon: "phone.fill", text: "+91 9284272940")
                    ContactRow(icon: "location.fill", text: "New Delhi, India")

                    HStack(spacing: 20) {
                        Text("Github")
                        Text("linkedin")
                        Text("Twitter")
                    }
                    .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Send Message Form
                VStack(spacing: 12) {
                    Text("Send a Message")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("Your Name", text: $name)
                        .textFieldStyle(ContactFieldStyle())

                    TextField("Your Email", text: $email)
                        .textFieldStyle(ContactFieldStyle())

                    TextField("Your Message", text: $message, axis: .vertical)
                        .textFieldStyle(ContactFieldStyle())
                        .frame(height: 100)

                    Button(action: {
                        // handle send action
                    }) {
                        HStack {
                            Text("Send Message")
                            Image(systemName: "paperplane.fill")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [.blue,.black], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                Spacer()
                .padding()
                .background(Color(.secondarySystemBackground).opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        .background(Color.gray.edgesIgnoringSafeArea(.all))
        .foregroundColor(.white)
    }
}

struct ContactRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundColor(.black)
            }
            Text(text)
                .foregroundColor(.white)
        }
    }
}

struct ContactFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

#Preview {
    ContactView()
}
