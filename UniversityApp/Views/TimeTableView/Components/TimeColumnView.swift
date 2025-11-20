import SwiftUI

struct TimeColumnView: View {
    let hourHeight: CGFloat
    let startHour: Int
    let timeColumnWidth: CGFloat = 60
    let verticalDividerWidth: CGFloat = 1
    let lineStartPadding: CGFloat = 4

    var body: some View {
        VStack(spacing: 0) {
            ForEach(startHour...24, id: \.self) { hour in
                ZStack(alignment: .top) {
                    Rectangle().fill(Color.clear).frame(height: hourHeight)

                    if hour < 24 {
                        Rectangle()
                            .fill(Color.gray.opacity(0.25))
                            .cornerRadius(10)
                            .frame(width: 20, height: 1)
                            .offset(y: hourHeight / 2)
                            .padding(.leading)
                            
                    }

                    Rectangle().fill(Color.gray.opacity(0.6)).frame(width: 35, height: 1).cornerRadius(10)

                    Text(String(format: "%02d:00", hour))
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(Color.gray.opacity(0.9)) 
                        .offset(y: -14)
                }
            }
        }
        .padding(.leading, lineStartPadding)
        .padding(.leading)
        .frame(width: timeColumnWidth)
        .background(Color("EFEFEF"))
    }
}
