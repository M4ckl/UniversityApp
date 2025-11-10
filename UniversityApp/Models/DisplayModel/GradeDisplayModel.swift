import SwiftUI


struct GradeModel: Identifiable, Equatable {
    let id: UUID
    let subjectName: String
    let eventType: String
    let gradeValue: Int

    var progress: CGFloat {
        return CGFloat(gradeValue) / 5.0
    }
    
    var color: Color {
        switch gradeValue {
        case 5:
            return .green
        case 4:
            return .blue
        case 3:
            return .orange
        default:
            return .red
        }
    }
    
    init(id: UUID = UUID(), subjectName: String, eventType: String, gradeValue: Int) {
        self.id = id
        self.subjectName = subjectName
        self.eventType = eventType
        self.gradeValue = gradeValue
    }
}
