import Foundation

struct HolidayEntity: Identifiable {
    let id = UUID()
    let date: Date
    let name: String
}

struct SessionPeriodEntity: Identifiable {
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let name: String
}
