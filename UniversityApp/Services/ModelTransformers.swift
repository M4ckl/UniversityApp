import Foundation

extension TeacherEntity {
    func toLektorModel(subjects: [SubjectEntity]) -> LektorModel {
        let subjectNames = subjects
            .filter { $0.teacherId == self.id }
            .map { $0.name }
        
        return LektorModel(
            id: self.id,
            name: self.fullName.components(separatedBy: " ").first ?? "",
            surname: self.fullName.components(separatedBy: " ").last ?? "",
            avatarName: self.avatarName,
            subjects: subjectNames
        )
    }
}

extension StudentEntity {
    func toStudentModel() -> StudentModel {
        return StudentModel(
            id: self.id,
            name: self.fullName.components(separatedBy: " ").first ?? "",
            surname: self.fullName.components(separatedBy: " ").last ?? "",
            avatarName: self.avatarName
        )
    }
}
