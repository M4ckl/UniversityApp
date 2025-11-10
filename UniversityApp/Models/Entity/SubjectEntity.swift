import Foundation

struct SubjectEntity: Identifiable, Hashable {
    let id: UUID
    var teacherId: UUID
    var name: String
    var credits: Int
    var iconName: String
}
