import Foundation

struct CourseYearEntity: Identifiable {
    let id: UUID
    var programId: UUID
    var yearNumber: Int
}
