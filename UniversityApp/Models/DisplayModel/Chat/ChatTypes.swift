import Foundation

struct StudentModel: Identifiable {
    let id: UUID
    let name: String
    let surname: String
    let avatarName: String
}

struct LektorModel: Identifiable {
    let id: UUID
    let name: String
    let surname: String
    let avatarName: String
    let subjects: [String]
}

enum ChatParticipant: Identifiable {
    case student(StudentModel)
    case lektor(LektorModel)
    
    var id: UUID {
        switch self {
        case .student(let s): return s.id
        case .lektor(let l): return l.id
        }
    }
    
    var fullName: String {
        switch self {
        case .student(let s): return "\(s.name) \(s.surname)"
        case .lektor(let l): return "\(l.name) \(l.surname)"
        }
    }

    var avatarName: String {
        switch self {
        case .student(let s): return s.avatarName
        case .lektor(let l): return l.avatarName
        }
    }
    
    var isStudent: Bool {
        if case .student = self { return true }
        return false
    }
    var isLektor: Bool {
        if case .lektor = self { return true }
        return false
    }
}

enum MessageStatus: Equatable {
    case idle
    case sent
    case read
    case incomingUnread
}
