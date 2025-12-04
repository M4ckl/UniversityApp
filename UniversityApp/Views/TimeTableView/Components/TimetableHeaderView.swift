import SwiftUI

struct TimetableHeaderView: View {
    @ObservedObject var viewModel: TimetableViewModel
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack {
            ForEach(viewModel.weekDays, id: \.self) { day in
                DayCellView(
                    day: day,
                    isSelected: day == viewModel.selectedDate.startOfDay(),
                    dayType: viewModel.getDayType(for: day),
                    namespace: animationNamespace,
                    onTap: { viewModel.selectDate(day) }
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 0)
        .padding(.horizontal)
        .background(Color("EFEFEF"))
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.selectedDate)
    }
}

struct DayCellView: View {
    let day: Date
    let isSelected: Bool
    let dayType: DayType
    let namespace: Namespace.ID
    let onTap: () -> Void
    
    private var dayColor: Color {
        if isSelected { return .red }
        
        switch dayType {
        case .holiday: return .red.opacity(0.8)
        case .session: return .green
        case .weekend: return .gray
        case .normal: return .primary
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text(day.dayNum)
                        .font(.headline)
                        .foregroundColor(dayColor)
                        .scaleEffect(isSelected ? 0.9 : 1.0)
                        .frame(height: 32)
                    
                    Text(day.dayShort)
                        .font(.caption.weight(.medium))
                        .foregroundColor(isSelected ? .red : .gray)
                        .scaleEffect(isSelected ? 1.4 : 1.0)
                }
                .padding(.vertical, 8)
                
                if isSelected {
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: 3)
                        .cornerRadius(5)
                        .mask(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 2 / 1)
                        }
                        .rotationEffect(.degrees(180))
                        .matchedGeometryEffect(id: "underline", in: namespace)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 3)
                }
            }
            .padding(.vertical, -1)
        }
        .buttonStyle(.plain)
    }
}
