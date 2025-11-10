import SwiftUI

struct LessonModel: Identifiable, Equatable {
    let id: UUID
    let subjectName: String
    let teacherName: String
    let classroom: String
    let type: String
    let typeColor: Color
    let iconName: String
    let startTime: Date
    let endTime: Date

    var durationHours: Double {
        return endTime.timeIntervalSince(startTime) / 3600.0
    }
    
    init(id: UUID = UUID(), subjectName: String, teacherName: String,
         classroom: String, type: String, typeColor: Color, iconName: String,
         startTime: Date, endTime: Date) {
        self.id = id
        self.subjectName = subjectName
        self.teacherName = teacherName
        self.classroom = classroom
        self.type = type
        self.typeColor = typeColor
        self.iconName = iconName
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func toScheduleItemModel(now: Date) -> ScheduleItemModel {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH.mm"
        let startTimeString = timeFormatter.string(from: startTime)
        let endTimeString = timeFormatter.string(from: endTime)

        let isHighlighted = (now >= startTime && now < endTime)
        
        return ScheduleItemModel(
            id: self.id,
            subjectName: self.subjectName,
            time: "\(startTimeString) - \(endTimeString)",
            isHighlighted: isHighlighted
        )
    }
}
