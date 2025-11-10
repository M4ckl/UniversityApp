import SwiftUI

struct GridLinesView: View {
    let hourHeight: CGFloat
    let startHour: Int
    let timeColumnWidth: CGFloat = 60
    let verticalDividerWidth: CGFloat = 1

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: verticalDividerWidth)
                .padding(.leading, timeColumnWidth)

            VStack(spacing: 0) {
                ForEach(startHour...24, id: \.self) { hour in
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(Color.clear).frame(height: hourHeight)
                        if hour < 24 {
                            Rectangle()
                                .fill(Color.gray.opacity(0.25))
                                .cornerRadius(10)
                                .frame(height: 1)
                                .offset(y: hourHeight / 2)
                                .padding(.horizontal, 64)
                        }
                        if hour < 24 {
                            Rectangle()
                                .fill(Color.gray.opacity(0.6))
                                .cornerRadius(10)
                                .frame(height: 1)
                                .offset(y: hourHeight)
                                .padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
    }
}
