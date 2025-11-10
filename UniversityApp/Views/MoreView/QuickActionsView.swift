import SwiftUI

struct QuickAction: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
}

struct QuickActionsView: View {
    let actions: [QuickAction] = [
        .init(title: "Payments", iconName: "creditcard"),
        .init(title: "Student ID", iconName: "person.text.rectangle"),
        .init(title: "MyID", iconName: "person.badge.key"),
        .init(title: "Email", iconName: "envelope"),
        .init(title: "Groups", iconName: "person.3")
    ]

    var body: some View {

        HStack(spacing: 8) {
            ForEach(actions) { action in
                QuickActionButton(action: action)
            }
        }
    }
}

struct QuickActionButton: View {
    let action: QuickAction

    var body: some View {
        Button {

        } label: {
            VStack(spacing: 8) {
                Image(systemName: action.iconName)
                    .font(.title3)
                    .foregroundColor(Color("ProfileColor"))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(Color("BlockColor"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                   .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
              
            .shadow(color: .black.opacity(0.05), radius: 5, y: 3)
        }
        .buttonStyle(.plain)
    }
}

