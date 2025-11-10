import SwiftUI

class MockScheduleService {
    
    static let shared = MockScheduleService()

    private let db = MockDatabaseService.shared
    
    private(set) var allLessons: [Date: [LessonModel]] = [:]
    private(set) var startOfWeek: Date = Date()
    
    init() {
        allLessons = createMockData()
    }
    
    func getLessons(for date: Date) -> [LessonModel] {
        return allLessons[date.startOfDay()] ?? []
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
