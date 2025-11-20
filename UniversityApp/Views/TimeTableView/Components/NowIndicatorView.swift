import SwiftUI
import Combine

struct NowIndicatorView: View {
    let hourHeight: CGFloat
    let startHour: Int
    
    let timeColumnWidth: CGFloat = 52
    let verticalDividerWidth: CGFloat = 1
    let indicatorColor = Color.red.opacity(0.8)
    let lineHeight: CGFloat = 2

    @State private var now: Date = AppContext.now()
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        Rectangle()
            .fill(indicatorColor)
            .frame(height: lineHeight)
            .cornerRadius(lineHeight / 2)
            .shadow(color: indicatorColor.opacity(0.5), radius: 3, y: 1)
            .padding(.leading, timeColumnWidth + verticalDividerWidth)
            .offset(y: calculateYOffset())
            .onReceive(timer) { _ in
                if !AppContext.isTesting { self.now = AppContext.now() }
            }
    }

    private func calculateYOffset() -> CGFloat {
         let calendar = Calendar.current
         let hour = calendar.component(.hour, from: now)
         let minute = calendar.component(.minute, from: now)
         guard hour >= startHour else { return -100 }
         let totalMinutesFromStart = (hour - startHour) * 60 + minute
         let pixelsPerMinute = hourHeight / 60.0
         return CGFloat(totalMinutesFromStart) * pixelsPerMinute - (lineHeight / 2)
    }
}
