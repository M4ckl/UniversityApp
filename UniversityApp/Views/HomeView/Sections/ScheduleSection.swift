import SwiftUI


struct ScheduleSection: View {

    @StateObject private var viewModel = ScheduleViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var showTimetable = false

    var body: some View {
        VStack(spacing: 12) {

            HStack {
                Text(viewModel.dayTitle)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("MainTextColor"))

                Spacer()

                Text(viewModel.dateString)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color("BlockColor"))
                    .cornerRadius(20)
            }
            .padding(.horizontal, 24)

            Button(action: {
                showTimetable = true
            }) {
                Group {
                    if viewModel.scheduleItems.isEmpty {
                        EmptyScheduleView()
                    } else {
                        VStack(spacing: 4) {
                            ForEach(viewModel.scheduleItems) { item in
                                ScheduleRow(item: item)
                                if item.id != viewModel.scheduleItems.last?.id {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 1)
                                        .padding(.leading, 12)
                                        .padding(.trailing, 112)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color("BlockColor"))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
                    }
                }
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }
}

struct ScheduleRow: View {
    
    let item: ScheduleItemModel
    
    var body: some View {
        HStack {
            Text(item.subjectName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("MainTextColor"))
            
            Spacer()
            
            if item.isHighlighted {
                    Text(item.time)
                                .font(.system(size: 15, weight: .semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .foregroundColor(.red)
                                .background(Color.red.opacity(0.15))
                                .cornerRadius(20)
            } else {
                     
                Text(item.time)
                    .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

import SwiftUI

struct EmptyScheduleView: View {
    var body: some View {
        HStack {
            Text("You have no classes today")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(40)
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
    }
}
