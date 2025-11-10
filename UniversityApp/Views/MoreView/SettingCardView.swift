import SwiftUI

struct SettingsCardView: View {
    let backgroundImageName = "background_service_3"
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button {
            
        } label: {
            ZStack(alignment: .leading) {
                Image(backgroundImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 80)
                    .cornerRadius(20)

                HStack(spacing: 20) {
                    Spacer()
                    VStack() {
                        Text("SETTINGS")
                            .font(.title.weight(.bold))
                            .foregroundColor(.gray.opacity(0.6))
                        Spacer()
                    }.padding(.top, 8)
                }
                .padding(.horizontal, 16)

            }
            .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.1), radius: 10, y: 5)

        }
        .buttonStyle(.plain)
    }
}
