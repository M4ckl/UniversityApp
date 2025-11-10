import Foundation

struct GroupEntity: Identifiable {
    let id: UUID
    var semesterId: UUID
    var name: String
    var curatorId: UUID?
}
