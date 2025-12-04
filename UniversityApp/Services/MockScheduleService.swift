import SwiftUI

enum DayType {
    case normal
    case holiday
    case session
    case weekend
}

class MockScheduleService {
    
    static let shared = MockScheduleService()
    private let db = MockDatabaseService.shared
    private let semesterStartDate: Date
    
    private(set) var allLessons: [Date: [LessonModel]] = [:]
    private(set) var startOfWeek: Date = Date()
    
    init() {
        var components = DateComponents()
        components.year = 2025
        components.month = 10
        components.day = 1
        self.semesterStartDate = Calendar.current.date(from: components)!
    }
    func getDayType(for date: Date) -> DayType {
        let checkDate = date.startOfDay()
        
        if db.holidays.contains(where: { $0.date.startOfDay() == checkDate }) {
            return .holiday
        }
        
        if db.sessions.contains(where: { checkDate >= $0.startDate && checkDate <= $0.endDate }) {
            return .session
        }
        
        let weekday = Calendar.current.component(.weekday, from: date)
        if weekday == 1 || weekday == 7 {
            return .weekend
        }
        
        return .normal
    }
    
    func getLessons(for date: Date) -> [LessonModel] {
        let type = getDayType(for: date)
        if type != .normal {
            return []
        }
        
        let calendar = Calendar.current
        let weekdaySystem = calendar.component(.weekday, from: date)
        let weekdayISO = (weekdaySystem == 1) ? 7 : weekdaySystem - 1
        
        let weekNumber = calendar.dateComponents([.weekOfYear], from: semesterStartDate, to: date).weekOfYear ?? 0
        let currentWeekType: WeekType = (weekNumber % 2 == 0) ? .odd : .even
        
        let relevantSchedules = db.schedules.filter { schedule in
            guard schedule.dayOfWeek == weekdayISO else { return false }
            return schedule.weekType == .both || schedule.weekType == currentWeekType
        }
        
        return relevantSchedules.compactMap { schedule -> LessonModel? in
            guard let subject = db.subjects.first(where: { $0.id == schedule.subjectId }),
                  let teacher = db.teachers.first(where: { $0.id == schedule.teacherId })
            else { return nil }
            
            let start = date.withTime(hour: Calendar.current.component(.hour, from: schedule.startTime),
                                      minute: Calendar.current.component(.minute, from: schedule.startTime))
            let end = date.withTime(hour: Calendar.current.component(.hour, from: schedule.endTime),
                                    minute: Calendar.current.component(.minute, from: schedule.endTime))
            
            return LessonModel(
                id: schedule.id,
                subjectName: subject.name,
                teacherName: teacher.fullName,
                classroom: schedule.room,
                type: schedule.type,
                typeColor: schedule.type.toColor(),
                iconName: subject.iconName,
                startTime: start,
                endTime: end
            )
        }
        .sorted(by: { $0.startTime < $1.startTime })
    }
    
    func getStartOfWeek(for date: Date) -> Date {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let daysToSubtract = (weekday == 1) ? 6 : (weekday - 2)
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: date)!
    }
    
    private func createMockData() -> [Date: [LessonModel]] {
        var lessonsByDate: [Date: [LessonModel]] = [:]
        
        let calendar = Calendar.current
        let today = AppContext.now().startOfDay()
        let weekday = calendar.component(.weekday, from: today)
        let daysToSubtract = (weekday == 1) ? 6 : (weekday - 2)
        let monday = calendar.date(byAdding: .day, value: -daysToSubtract, to: today)!
        self.startOfWeek = monday
        
        let groupedSchedules = Dictionary(grouping: db.schedules, by: { $0.startTime.startOfDay() })
        
        for (date, scheduleEntities) in groupedSchedules {
            let lessonModels = scheduleEntities.compactMap { schedule -> LessonModel? in
                guard let subject = db.subjects.first(where: { $0.id == schedule.subjectId }),
                      let teacher = db.teachers.first(where: { $0.id == schedule.teacherId })
                else {
                    return nil
                }
                
                return LessonModel(
                    id: schedule.id,
                    subjectName: subject.name,
                    teacherName: teacher.fullName,
                    classroom: schedule.room,
                    type: schedule.type,
                    typeColor: schedule.type.toColor(),
                    iconName: subject.iconName,
                    startTime: schedule.startTime,
                    endTime: schedule.endTime
                )
            }
            lessonsByDate[date] = lessonModels
        }
        
        return lessonsByDate
    }
}

extension String {
    func toColor() -> Color {
        switch self.lowercased() {
        case "lection": return .blue
        case "practice": return .orange
        case "computer": return .purple
        default: return .gray
        }
    }
}
