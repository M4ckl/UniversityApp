import Foundation

struct AppContext {
    static let isTesting = true

    private static var mockTime: Date {
        let components = DateComponents(year: 2025, month: 10, day: 14, hour: 12, minute: 40)
        return Calendar.current.date(from: components) ?? Date()
    }

    static func now() -> Date {
        return isTesting ? mockTime : Date()
    }
}
