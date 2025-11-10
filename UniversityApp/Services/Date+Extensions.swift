import Foundation

extension Date {

    func withTime(hour: Int, minute: Int) -> Date {
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self) ?? self
    }

    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }

    var dayShort: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }

    var dayNum: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }

    var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self).uppercased()
    }

    var longDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: self)
    }
}
