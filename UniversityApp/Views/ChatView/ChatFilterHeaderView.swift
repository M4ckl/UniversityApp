import SwiftUI

struct ChatFilterHeaderView: View {
    @Binding var selectedFilter: FilterType
    @Namespace private var animationNamespace

    var body: some View {
        VStack(spacing: 0){
            HStack {
                ForEach(FilterType.allCases, id: \.self) { filter in
                    ChatFilterButtonView(
                        filter: filter,
                        isSelected: filter == selectedFilter,
                        namespace: animationNamespace,
                        onTap: { selectedFilter = filter }
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 16)
            .padding(.horizontal)
            .background(Color("202020"))
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: selectedFilter)
            Divider()
        }
    }
}

struct ChatFilterButtonView: View {
    let filter: FilterType
    let isSelected: Bool
    let namespace: Namespace.ID
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                HStack(spacing: 4) {
                    Image(systemName: isSelected ? filter.selectedIconName : filter.iconName)
                        .font(.system(size: 16))
                    Text(filter.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(isSelected ? .red : .gray)
                .scaleEffect(isSelected ? 1.05 : 1.0)
                .padding(.vertical, 8)

                if isSelected {
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 3)
                            .cornerRadius(6)
                            .padding(.horizontal)
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
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected)
    }
}
