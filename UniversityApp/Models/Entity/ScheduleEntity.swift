import Foundation

enum WeekType: Int, CaseIterable {
    case both = 0
    case odd = 1
    case even = 2
}

struct ScheduleEntity: Identifiable, Hashable {
    let id: UUID
    var subjectId: UUID
    var groupId: UUID
    var teacherId: UUID
    var dayOfWeek: Int
    var startTime: Date
    var endTime: Date
    var room: String
    var type: String
    var weekType: WeekType = .both
}
