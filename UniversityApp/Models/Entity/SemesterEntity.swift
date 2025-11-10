import Foundation

struct SemesterEntity: Identifiable {
    let id: UUID
    var courseYearId: UUID
    var semesterNumber: Int
    var startDate: Date
    var endDate: Date
}
