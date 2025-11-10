import Foundation

struct GradeEntity: Identifiable {
    let id: UUID
    var studentId: UUID
    var taskId: UUID
    var markValue: Int
    var dateGiven: Date
}
