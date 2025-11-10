import SwiftUI
import Combine

class GradesViewModel: ObservableObject {
    
    @Published var visibleGrades: [GradeModel] = []
    private var allGrades: [GradeModel] = []
    
    private let db = MockDatabaseService.shared
    
    init() { loadData() }
    
    func loadData() {
        let studentGrades = db.grades.filter { $0.studentId == db.mainStudent.id }

        self.allGrades = studentGrades.compactMap { grade -> GradeModel? in
            guard let task = db.tasks.first(where: { $0.id == grade.taskId }),
                  let subject = db.subjects.first(where: { $0.id == task.subjectId })
            else {
                return nil
            }
            
            return GradeModel(
                id: grade.id,
                subjectName: subject.name,
                eventType: task.type,
                gradeValue: grade.markValue
            )
        }

        self.visibleGrades = Array(allGrades.prefix(2))
        self.allGrades = Array(allGrades.dropFirst(2))
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
