import Foundation

enum SearchableItem: Identifiable, Hashable {
    case student(StudentEntity)
    case teacher(TeacherEntity)
    case subject(SubjectEntity)

    var id: UUID {
        switch self {
        case .student(let s): return s.id
        case .teacher(let t): return t.id
        case .subject(let s): return s.id
        }
    }

    var title: String {
        switch self {
        case .student(let s): return s.fullName
        case .teacher(let t): return t.fullName
        case .subject(let s): return s.name
        }
    }
    
    var description: String {
        switch self {
        case .student: return "Student"
        case .teacher: return "Teacher"
        case .subject: return "Subject"
        }
    }
    
    var iconName: String {
        switch self {
        case .student(let s): return s.avatarName
        case .teacher(let t): return t.avatarName
        case .subject(let s): return s.iconName
        }
    }
    
    var isSFSymbol: Bool {
        switch self {
        case .student, .teacher:
            return false
        case .subject(let subject):
            return subject.iconName.contains(".") || subject.iconName.count < 10
        }
    }
    
    var isSubject: Bool {
        if case .subject = self { return true }
        return false
    }
}
