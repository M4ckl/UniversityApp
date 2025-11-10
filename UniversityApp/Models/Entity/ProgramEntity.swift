import Foundation

struct ProgramEntity: Identifiable {
    let id: UUID
    var departmentId: UUID
    var name: String
    var degreeType: String
}
