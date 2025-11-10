import SwiftUI

struct ProfileCardView: View {
    private let db = MockDatabaseService.shared
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack(alignment: .topTrailing) {

            RoundedRectangle(cornerRadius: 25)
                .fill(Color("ProfileColor"))
                .shadow(color: .black.opacity(0.1), radius: 10, y: 5)

            HStack(spacing: 0) {
                Image(db.mainStudent.avatarName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .padding(8)

                VStack(alignment: .leading, spacing: 0) {
                    Text("Студент")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color("MainTextColor").opacity(0.9))
                    Text(db.mainStudent.fullName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color("MainTextColor"))
                }
                Spacer()
            }
            VStack{
                Spacer()
                Text("PROFILE")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color("ProfileColor"))
                    .brightness(0.1)
                    .padding(.trailing, 20)
                    .padding(.bottom, 15)
            }
        }
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
        .frame(height: 130)
    }
}
