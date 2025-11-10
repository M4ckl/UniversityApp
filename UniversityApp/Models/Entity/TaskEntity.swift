import Foundation

struct TaskEntity: Identifiable {
    let id: UUID
    var subjectId: UUID
    var teacherId: UUID
    var title: String
    var type: String
    var dueDate: Date
}
