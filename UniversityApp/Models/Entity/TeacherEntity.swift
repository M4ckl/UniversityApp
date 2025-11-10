import Foundation

struct TeacherEntity: Identifiable, Hashable {
    let id: UUID
    var fullName: String
    var academicTitle: String
    var email: String
    var avatarName: String
}
