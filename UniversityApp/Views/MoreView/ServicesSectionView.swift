import SwiftUI

struct ServicesSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Services")
                .font(.title.weight(.bold))
                .foregroundColor(Color("MainTextColor"))
                .padding(.leading, 8)

            HStack(spacing: 8) {
                ServiceCardView(
                    title: "Dean's Office",
                    titleColor: "ColorTitle_1",
                    imageName: "background_service_1"
                )
                ServiceCardView(
                    title: "NEWS",
                    titleColor: "ColorTitle_2",
                    imageName: "background_service_2"
                )
            }
        }
    }
}

struct ServiceCardView: View {
    let title: String
    let titleColor: String
    let imageName: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button {

        } label: {
           
            ZStack(alignment: .topLeading) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .cornerRadius(20)
                Text(title)
                    .font(.title2.weight(.bold))
                    .foregroundColor(Color(titleColor))
                    .padding(12)

            }
            .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)

        }
        .buttonStyle(ScaleButtonStyle())
    }
}
