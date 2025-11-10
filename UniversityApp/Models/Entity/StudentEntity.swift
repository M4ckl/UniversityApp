import Foundation

struct StudentEntity: Identifiable, Hashable {
    let id: UUID
    var groupId: UUID
    var fullName: String
    var email: String
    var avatarName: String
}
