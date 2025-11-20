import SwiftUI
import Combine

struct TimetableView: View {

    @StateObject private var viewModel = TimetableViewModel()
    @State private var selectedLesson: LessonModel? = nil
    
    private let hourHeight: CGFloat = 80.0
    private let startHour: Int = 4
    private let visibleStartHour: Int = 8
    private let drawingEndHour: Int = 24
    private let timeColumnWidth: CGFloat = 70
    private let headerApproxHeight: CGFloat = 100
    
    private var contentOffsetY: CGFloat {
        return -CGFloat(visibleStartHour - startHour) * (hourHeight/(3/2))
    }
    
    private var bottomSpacing: CGFloat {
            return -(hourHeight * 2)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()

                VStack(spacing: 0) {
                    TimetableHeaderView(viewModel: viewModel)
                    Divider()
                    ScrollView {
                        ZStack(alignment: .topLeading) {
                            GridLinesView(
                                hourHeight: hourHeight,
                                startHour: startHour,
                            )
                            ForEach(viewModel.lessons) { lesson in
                                LessonBlockView(
                                    lesson: lesson,
                                    onMoreTapped: {
                                        withAnimation(.spring()) {
                                            selectedLesson = lesson
                                        }
                                    }
                                )
                                .frame(height: lesson.durationHours * hourHeight - 4)
                                .offset(y: calculateYOffset(for: lesson.startTime) + 2)
                            }
                            if viewModel.selectedDate.startOfDay() == AppContext.now().startOfDay() {
                                NowIndicatorView(hourHeight: hourHeight, startHour: startHour)
                            }
                            TimeColumnView(hourHeight: hourHeight, startHour: startHour)
                        }
                        .padding(.top, contentOffsetY)
                        .padding(.bottom, bottomSpacing)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Text("September 2025")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("MainTextColor"))
                        Image(systemName: "clock")
                            .foregroundColor(.red)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("EFEFEF"), for: .navigationBar)
            .overlay {
                if let lesson = selectedLesson {
                    SubjectDetailView(lesson: lesson) {
                        withAnimation(.spring()) {
                            selectedLesson = nil
                        }
                    }
                }
            }
        }
    }

    private func calculateYOffset(for time: Date) -> CGFloat {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        let totalMinutesFromStart = (hour - startHour) * 60 + minute
        let pixelsPerMinute = hourHeight / 60.0
        return CGFloat(totalMinutesFromStart) * pixelsPerMinute
    }
}

struct Timetable_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView()
    }
}
