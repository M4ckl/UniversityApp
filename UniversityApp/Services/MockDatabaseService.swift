import SwiftUI

class MockDatabaseService {
    
    static let shared = MockDatabaseService()
    
    private(set) var universities: [UniversityEntity] = []
    private(set) var departments: [DepartmentEntity] = []
    private(set) var programs: [ProgramEntity] = []
    private(set) var courseYears: [CourseYearEntity] = []
    private(set) var semesters: [SemesterEntity] = []
    private(set) var groups: [GroupEntity] = []
    private(set) var students: [StudentEntity] = []
    private(set) var teachers: [TeacherEntity] = []
    private(set) var subjects: [SubjectEntity] = []
    private(set) var schedules: [ScheduleEntity] = []
    private(set) var tasks: [TaskEntity] = []
    private(set) var grades: [GradeEntity] = []
    private(set) var news: [NewsEntity] = []
    
    private(set) var mainStudent: StudentEntity!
    
    private init() {
        createMockData()
    }
    
    private func createMockData() {
        
        let calendar = Calendar.current
        
        let t_ada = TeacherEntity(id: UUID(), fullName: "Dr. Ada Lovelace", academicTitle: "Professor", email: "ada@uni.edu", avatarName: "teacher_avatar_1")
        let t_turing = TeacherEntity(id: UUID(), fullName: "Prof. Alan Turing", academicTitle: "Professor", email: "turing@uni.edu", avatarName: "teacher_avatar_2")
        let t_euclid = TeacherEntity(id: UUID(), fullName: "Dr. Euclid", academicTitle: "Associate Professor", email: "euclid@uni.edu", avatarName: "person.fill")
        let t_ive = TeacherEntity(id: UUID(), fullName: "Mr. Jony Ive", academicTitle: "Lecturer", email: "jony@uni.edu", avatarName: "teacher_avatar_3")
        let t_volt = TeacherEntity(id: UUID(), fullName: "Dr. Volt", academicTitle: "Lecturer", email: "volt@uni.edu", avatarName: "teacher_avatar_4")
        let t_plato = TeacherEntity(id: UUID(), fullName: "Prof. Plato", academicTitle: "Professor", email: "plato@uni.edu", avatarName: "teacher_avatar_5")
        let t_codd = TeacherEntity(id: UUID(), fullName: "Mr. Codd", academicTitle: "Lecturer", email: "codd@uni.edu", avatarName: "teacher_avatar_6")
        let t_dijkstra = TeacherEntity(id: UUID(), fullName: "Prof. Dijkstra", academicTitle: "Professor", email: "dijkstra@uni.edu", avatarName: "teacher_avatar_7")
        let t_armstrong = TeacherEntity(id: UUID(), fullName: "Coach Armstrong", academicTitle: "Lecturer", email: "gym@uni.edu", avatarName: "teacher_avatar_8")
        let t_herodotus = TeacherEntity(id: UUID(), fullName: "Prof. Herodotus", academicTitle: "Professor", email: "history@uni.edu", avatarName: "teacher_avatar_9")
        self.teachers = [t_ada, t_turing, t_euclid, t_ive, t_volt, t_plato, t_codd, t_dijkstra, t_armstrong, t_herodotus]
        
        let uni = UniversityEntity(id: UUID(), name: "My University", address: "123 Swift St.")
        self.universities = [uni]
        
        let dept_cs = DepartmentEntity(id: UUID(), universityId: uni.id, name: "Faculty of Computer Science")
        self.departments = [dept_cs]
        
        let prog_se = ProgramEntity(id: UUID(), departmentId: dept_cs.id, name: "Software Engineering", degreeType: "Bachelor")
        self.programs = [prog_se]
        
        let course_3 = CourseYearEntity(id: UUID(), programId: prog_se.id, yearNumber: 3)
        self.courseYears = [course_3]
        
        let sem_5 = SemesterEntity(id: UUID(), courseYearId: course_3.id, semesterNumber: 1, startDate: Date(), endDate: Date())
        self.semesters = [sem_5]
        
        let group_isp31 = GroupEntity(id: UUID(), semesterId: sem_5.id, name: "ISP-31", curatorId: t_turing.id)
        self.groups = [group_isp31]
        
        self.mainStudent = StudentEntity(id: UUID(), groupId: group_isp31.id, fullName: "Mikhail Ramaniuk", email: "mikhail@student.edu", avatarName: "main_student_avatar")
        let s_one = StudentEntity(id: UUID(), groupId: group_isp31.id, fullName: "Oliver Bennett", email: "s1@student.edu", avatarName: "student_avatar_1")
        let s_two = StudentEntity(id: UUID(), groupId: group_isp31.id, fullName: "Amelia Collins", email: "s2@student.edu", avatarName: "student_avatar_2")
        let s_three = StudentEntity(id: UUID(), groupId: group_isp31.id, fullName: "James Turner", email: "s3@student.edu", avatarName: "student_avatar_3")
        let s_four = StudentEntity(id: UUID(), groupId: group_isp31.id, fullName: "Sophie Harris", email: "s4@student.edu", avatarName: "student_avatar_4")
        self.students = [mainStudent, s_one, s_two, s_three, s_four]
        
        let subj_prog = SubjectEntity(id: UUID(), teacherId: t_ada.id, name: "Programming", credits: 5, iconName: "subject_avatar_1")
        let subj_opd = SubjectEntity(id: UUID(), teacherId: t_turing.id, name: "OPD", credits: 4, iconName: "subject_avatar_2")
        let subj_math = SubjectEntity(id: UUID(), teacherId: t_euclid.id, name: "Mathematics", credits: 6, iconName: "subject_avatar_3")
        let subj_design = SubjectEntity(id: UUID(), teacherId: t_ive.id, name: "Design", credits: 3, iconName: "subject_avatar_4")
        let subj_physics = SubjectEntity(id: UUID(), teacherId: t_volt.id, name: "Physics", credits: 4, iconName: "subject_avatar_5")
        let subj_philosophy = SubjectEntity(id: UUID(), teacherId: t_plato.id, name: "Philosophy", credits: 3, iconName: "subject_avatar_6")
        let subj_databases = SubjectEntity(id: UUID(), teacherId: t_codd.id, name: "Databases", credits: 4, iconName: "subject_avatar_7")
        let subj_algorithms = SubjectEntity(id: UUID(), teacherId: t_dijkstra.id, name: "Algorithms", credits: 5, iconName: "subject_avatar_8")
        let subj_physed = SubjectEntity(id: UUID(), teacherId: t_armstrong.id, name: "Physical Ed.", credits: 2, iconName: "subject_avatar_9")
        let subj_history = SubjectEntity(id: UUID(), teacherId: t_herodotus.id, name: "History", credits: 3, iconName: "subject_avatar_10")
        self.subjects = [subj_prog, subj_opd, subj_math, subj_design, subj_physics, subj_philosophy, subj_databases, subj_algorithms, subj_physed, subj_history]
        
        let today = AppContext.now().startOfDay()
        let weekday = calendar.component(.weekday, from: today)
        let daysToSubtract = (weekday == 1) ? 6 : (weekday - 2)
        let monday = calendar.date(byAdding: .day, value: -daysToSubtract, to: today)!
        let tuesday = calendar.date(byAdding: .day, value: 1, to: monday)!
        let wednesday = calendar.date(byAdding: .day, value: 2, to: monday)!
        let thursday = calendar.date(byAdding: .day, value: 3, to: monday)!
        let friday = calendar.date(byAdding: .day, value: 4, to: monday)!
        
        self.schedules = [
            ScheduleEntity(id: UUID(), subjectId: subj_prog.id, groupId: group_isp31.id, teacherId: t_ada.id, dayOfWeek: 2, startTime: monday.withTime(hour: 10, minute: 0), endTime: monday.withTime(hour: 11, minute: 30), room: "909", type: "Lection"),
            ScheduleEntity(id: UUID(), subjectId: subj_opd.id, groupId: group_isp31.id, teacherId: t_turing.id, dayOfWeek: 2, startTime: monday.withTime(hour: 11, minute: 45), endTime: monday.withTime(hour: 13, minute: 15), room: "234A", type: "Practice"),
            ScheduleEntity(id: UUID(), subjectId: subj_math.id, groupId: group_isp31.id, teacherId: t_euclid.id, dayOfWeek: 2, startTime: monday.withTime(hour: 14, minute: 0), endTime: monday.withTime(hour: 15, minute: 30), room: "201", type: "Lection"),
            ScheduleEntity(id: UUID(), subjectId: subj_design.id, groupId: group_isp31.id, teacherId: t_ive.id, dayOfWeek: 2, startTime: monday.withTime(hour: 18, minute: 30), endTime: monday.withTime(hour: 20, minute: 0), room: "301", type: "Computer"),
            
            ScheduleEntity(id: UUID(), subjectId: subj_physics.id, groupId: group_isp31.id, teacherId: t_volt.id, dayOfWeek: 3, startTime: tuesday.withTime(hour: 9, minute: 0), endTime: tuesday.withTime(hour: 10, minute: 30), room: "101", type: "Practice"),
            ScheduleEntity(id: UUID(), subjectId: subj_philosophy.id, groupId: group_isp31.id, teacherId: t_plato.id, dayOfWeek: 3, startTime: tuesday.withTime(hour: 11, minute: 0), endTime: tuesday.withTime(hour: 12, minute: 30), room: "505", type: "Lection"),
            
            ScheduleEntity(id: UUID(), subjectId: subj_databases.id, groupId: group_isp31.id, teacherId: t_codd.id, dayOfWeek: 4, startTime: wednesday.withTime(hour: 10, minute: 0), endTime: wednesday.withTime(hour: 11, minute: 30), room: "DB2", type: "Computer"),
            ScheduleEntity(id: UUID(), subjectId: subj_algorithms.id, groupId: group_isp31.id, teacherId: t_dijkstra.id, dayOfWeek: 4, startTime: wednesday.withTime(hour: 14, minute: 0), endTime: wednesday.withTime(hour: 15, minute: 30), room: "101", type: "Lection"),
            
            ScheduleEntity(id: UUID(), subjectId: subj_physed.id, groupId: group_isp31.id, teacherId: t_armstrong.id, dayOfWeek: 5, startTime: thursday.withTime(hour: 8, minute: 0), endTime: thursday.withTime(hour: 9, minute: 30), room: "GYM", type: "Practice"),
            ScheduleEntity(id: UUID(), subjectId: subj_history.id, groupId: group_isp31.id, teacherId: t_herodotus.id, dayOfWeek: 5, startTime: thursday.withTime(hour: 10, minute: 0), endTime: thursday.withTime(hour: 11, minute: 30), room: "303", type: "Lection"),
            
            ScheduleEntity(id: UUID(), subjectId: subj_prog.id, groupId: group_isp31.id, teacherId: t_ada.id, dayOfWeek: 6, startTime: friday.withTime(hour: 12, minute: 0), endTime: friday.withTime(hour: 13, minute: 30), room: "909", type: "Practice")
        ]

        let task_prog = TaskEntity(id: UUID(), subjectId: subj_prog.id, teacherId: t_ada.id, title: "Exam", type: "exam", dueDate: Date())
        let task_opd = TaskEntity(id: UUID(), subjectId: subj_opd.id, teacherId: t_turing.id, title: "Kolokwium", type: "kolokwium", dueDate: Date())
        let task_math = TaskEntity(id: UUID(), subjectId: subj_math.id, teacherId: t_euclid.id, title: "Test", type: "test", dueDate: Date())
        let task_design = TaskEntity(id: UUID(), subjectId: subj_design.id, teacherId: t_ive.id, title: "Project", type: "project", dueDate: Date())
        self.tasks = [task_prog, task_opd, task_math, task_design]

        self.grades = [
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_prog.id, markValue: 4, dateGiven: Date()),
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_opd.id, markValue: 5, dateGiven: Date()),
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_math.id, markValue: 3, dateGiven: Date()),
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_design.id, markValue: 5, dateGiven: Date())
        ]

        self.news = [
            NewsEntity(id: UUID(), universityId: uni.id, title: "Tech pause", subtitle: "from 8 to 12 pm", content: "Full description of the technical break.", date: Date(), imageName: "card_news")
        ]
    }
}
