import Foundation

struct ScheduleEntity: Identifiable {
    let id: UUID
    var subjectId: UUID
    var groupId: UUID
    var teacherId: UUID
    var dayOfWeek: Int
    var startTime: Date
    var endTime: Date
    var room: String
    var type: String
}
