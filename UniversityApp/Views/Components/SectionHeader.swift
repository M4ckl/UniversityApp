import SwiftUI

struct SectionHeader: View {
    let title: String
    var onMoreTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color("MainTextColor"))
            Spacer()
            Button("more »") {
                onMoreTapped?()
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.gray)
        }
        .padding(.horizontal, 24)
    }
}
