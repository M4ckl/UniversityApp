import SwiftUI
import Combine

class GradesViewModel: ObservableObject {
    
    @Published var visibleGrades: [GradeModel] = []
    var allGrades: [GradeModel] = []
    private var remainingGrades: [GradeModel] = []
    @Published var selectedGrade: GradeModel? = nil
    private let db = MockDatabaseService.shared
    
    init() { loadData() }
    
    func loadData() {
        let studentGrades = db.grades.filter { $0.studentId == db.mainStudent.id }

        let convertedGrades = studentGrades.compactMap { grade -> GradeModel? in
            guard let task = db.tasks.first(where: { $0.id == grade.taskId }),
                  let subject = db.subjects.first(where: { $0.id == task.subjectId })
            else {
                return nil
            }
            
            let teacher = db.teachers.first(where: { $0.id == subject.teacherId })
            let teacherName = teacher?.fullName ?? "Unknown Teacher"
            
            return GradeModel(
                id: grade.id,
                subjectName: subject.name,
                eventType: task.type,
                gradeValue: grade.markValue,
                teacherName: teacherName
            )
        }

        self.allGrades = convertedGrades

        self.visibleGrades = Array(convertedGrades.prefix(2))

        self.remainingGrades = Array(convertedGrades.dropFirst(2))
    }
    
    func addNewGrade() {
        guard !allGrades.isEmpty else { return }
        
        let newGrade = allGrades.removeFirst()
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            visibleGrades.append(newGrade)
            
            if visibleGrades.count > 2 {
                visibleGrades.removeFirst()
            }
        }
    }
}
