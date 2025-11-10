import SwiftUI
import Combine

class TimetableViewModel: ObservableObject {
    
    @Published var selectedDate: Date
    @Published var weekDays: [Date] = []
    @Published var lessons: [LessonModel] = []

    private let scheduleService = MockScheduleService.shared
    
    init() {
        self.selectedDate = AppContext.now().startOfDay()
        updateWeekDays()
        loadLessonsForSelectedDate()
    }
    
    func selectDate(_ date: Date) {
        withAnimation(.spring()) {
            selectedDate = date
            loadLessonsForSelectedDate()
        }
    }
    
    private func updateWeekDays() {
        let calendar = Calendar.current
        let monday = scheduleService.startOfWeek
        
        self.weekDays = (0...4).map {
            calendar.date(byAdding: .day, value: $0, to: monday)!
        }
    }
    
    private func loadLessonsForSelectedDate() {
        self.lessons = scheduleService.getLessons(for: selectedDate)
    }
}
