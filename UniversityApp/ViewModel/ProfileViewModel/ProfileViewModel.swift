import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    private let db = MockDatabaseService.shared

    @Published var studentName: String = ""
    @Published var studentAvatar: String = ""
    @Published var studentID: String = ""
    @Published var department: String = "Loading..."
    @Published var program: String = "Loading..."
    @Published var course: String = "-"
    @Published var groupName: String = "-"
    @Published var averageGrade: String = "0.0"
    @Published var status: String = "Active"
    
    init() {
        loadProfileData()
    }
    
    func loadProfileData() {
        guard let student = db.mainStudent else {
            self.studentName = ""
            self.studentAvatar = ""
            self.studentID = ""
            self.department = "-"
            self.program = "-"
            self.course = "-"
            self.groupName = "-"
            self.averageGrade = "0.0"
            self.status = "Inactive"
            return
        }
        
        self.studentName = student.fullName
        self.studentAvatar = student.avatarName
        self.studentID = String(student.id.uuidString.prefix(8)).uppercased()
        if let group = db.groups.first(where: { $0.id == student.groupId }) {
            self.groupName = group.name

            if let semester = db.semesters.first(where: { $0.id == group.semesterId }),
               let courseObj = db.courseYears.first(where: { $0.id == semester.courseYearId }) {
                self.course = "\(courseObj.yearNumber) Course"

                if let prog = db.programs.first(where: { $0.id == courseObj.programId }) {
                    self.program = prog.name

                    if let dept = db.departments.first(where: { $0.id == prog.departmentId }) {
                        self.department = dept.name
                    }
                }
            }
        }

        let myGrades = db.grades.filter { $0.studentId == student.id }
        if !myGrades.isEmpty {
            let total = myGrades.reduce(0) { $0 + $1.markValue }
            let avg = Double(total) / Double(myGrades.count)
            self.averageGrade = String(format: "%.2f", avg)
        }
    }
}
