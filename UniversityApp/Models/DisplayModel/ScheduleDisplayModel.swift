import Foundation

struct ScheduleItemModel: Identifiable {
    let id: UUID
    let subjectName: String
    let time: String
    let isHighlighted: Bool
    
    init(id: UUID = UUID(), subjectName: String, time: String, isHighlighted: Bool = false) {
        self.id = id
        self.subjectName = subjectName
        self.time = time
        self.isHighlighted = isHighlighted
    }
}
