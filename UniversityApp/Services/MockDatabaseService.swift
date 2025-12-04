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
    private(set) var holidays: [HolidayEntity] = []
    private(set) var sessions: [SessionPeriodEntity] = []
    
    private(set) var mainStudent: StudentEntity!
    
    private init() {
        createMockData()
    }
    
    private func createMockData() {
        
        
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
        
        let subj_prog = SubjectEntity(id: UUID(), teacherId: t_ada.id, name: "Programming 3", credits: 5, iconName: "subject_avatar_1")
        let subj_bot = SubjectEntity(id: UUID(), teacherId: t_turing.id, name: "Basic of Technologies", credits: 4, iconName: "subject_avatar_2")
        let subj_bog = SubjectEntity(id: UUID(), teacherId: t_euclid.id, name: "Basic of Graphics", credits: 6, iconName: "subject_avatar_3")
        let subj_net = SubjectEntity(id: UUID(), teacherId: t_ive.id, name: "Computer Networks", credits: 3, iconName: "subject_avatar_4")
        let subj_engl = SubjectEntity(id: UUID(), teacherId: t_volt.id, name: "English", credits: 4, iconName: "subject_avatar_5")
        let subj_pms = SubjectEntity(id: UUID(), teacherId: t_plato.id, name: "Probilistic Methods and Statistics", credits: 3, iconName: "subject_avatar_6")
        let subj_databases = SubjectEntity(id: UUID(), teacherId: t_codd.id, name: "Database Systems", credits: 4, iconName: "subject_avatar_7")
        let subj_physed = SubjectEntity(id: UUID(), teacherId: t_armstrong.id, name: "Physical Education", credits: 2, iconName: "subject_avatar_9")
        self.subjects = [subj_prog, subj_bot, subj_bog, subj_net, subj_engl, subj_pms, subj_databases, subj_physed]
        
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd"
        
        func date(_ str: String) -> Date {
            return isoFormatter.date(from: str) ?? Date()
        }
        
        self.holidays = [
            HolidayEntity(date: date("2025-01-01"), name: "Nowy Rok"),
            HolidayEntity(date: date("2025-01-06"), name: "Trzech Króli"),
            HolidayEntity(date: date("2025-04-20"), name: "Wielkanoc"),
            HolidayEntity(date: date("2025-04-21"), name: "Poniedziałek Wielkanocny"),
            HolidayEntity(date: date("2025-05-01"), name: "Święto Pracy"),
            HolidayEntity(date: date("2025-05-03"), name: "Święto Konstytucji 3 Maja"),
            HolidayEntity(date: date("2025-06-08"), name: "Zielone Świątki"),
            HolidayEntity(date: date("2025-06-19"), name: "Boże Ciało"),
            HolidayEntity(date: date("2025-08-15"), name: "Wniebowzięcie NMP"),
            HolidayEntity(date: date("2025-11-01"), name: "Wszystkich Świętych"),
            HolidayEntity(date: date("2025-11-11"), name: "Święto Niepodległości"),
            HolidayEntity(date: date("2025-12-25"), name: "Boże Narodzenie (1)"),
            HolidayEntity(date: date("2025-12-26"), name: "Boże Narodzenie (2)")
        ]
        
        self.sessions = [
            SessionPeriodEntity(startDate: date("2026-01-26"), endDate: date("2026-02-8"), name: "Sesja Zimowa"),
            SessionPeriodEntity(startDate: date("2026-02-16"), endDate: date("2026-02-22"), name: "Sesja Zimowa Powtorna"),
            SessionPeriodEntity(startDate: date("2026-06-15"), endDate: date("2026-07-5"), name: "Sesja Letnia")
        ]
        
        let baseDate = Date().startOfDay()
        
        self.schedules = [
            ScheduleEntity(id: UUID(), subjectId: subj_pms.id, groupId: group_isp31.id, teacherId: t_ada.id, dayOfWeek: 1, startTime: baseDate.withTime(hour: 8, minute: 15), endTime: baseDate.withTime(hour: 10, minute: 00), room: "134T", type: "Lection", weekType: .both),
            ScheduleEntity(id: UUID(), subjectId: subj_bog.id, groupId: group_isp31.id, teacherId: t_turing.id, dayOfWeek: 1, startTime: baseDate.withTime(hour: 10, minute: 10), endTime: baseDate.withTime(hour: 11, minute: 50), room: "A171", type: "Practice", weekType: .both),
            ScheduleEntity(id: UUID(), subjectId: subj_net.id, groupId: group_isp31.id, teacherId: t_turing.id, dayOfWeek: 1, startTime: baseDate.withTime(hour: 12, minute: 00), endTime: baseDate.withTime(hour: 13, minute: 40), room: "b273", type: "Practice", weekType: .both),
            ScheduleEntity(id: UUID(), subjectId: subj_bog.id, groupId: group_isp31.id, teacherId: t_turing.id, dayOfWeek: 1, startTime: baseDate.withTime(hour: 14, minute: 00), endTime: baseDate.withTime(hour: 16, minute: 10), room: "134T", type: "Lection", weekType: .both),
            
            ScheduleEntity(id: UUID(), subjectId: subj_databases.id, groupId: group_isp31.id, teacherId: t_euclid.id, dayOfWeek: 2, startTime: baseDate.withTime(hour: 8, minute: 30), endTime: baseDate.withTime(hour: 10, minute: 15), room: "A171", type: "Practice", weekType: .both),
            ScheduleEntity(id: UUID(), subjectId: subj_engl.id, groupId: group_isp31.id, teacherId: t_ive.id, dayOfWeek: 2, startTime: baseDate.withTime(hour: 10, minute: 25), endTime: baseDate.withTime(hour: 12, minute: 15), room: "A271", type: "Practice", weekType: .both),
            ScheduleEntity(id: UUID(), subjectId: subj_databases.id, groupId: group_isp31.id, teacherId: t_euclid.id, dayOfWeek: 2, startTime: baseDate.withTime(hour: 12, minute: 30), endTime: baseDate.withTime(hour: 14, minute: 00), room: "134T", type: "Lection", weekType: .both),
            ScheduleEntity(id: UUID(), subjectId: subj_physed.id, groupId: group_isp31.id, teacherId: t_euclid.id, dayOfWeek: 2, startTime: baseDate.withTime(hour: 17, minute: 30), endTime: baseDate.withTime(hour: 19, minute: 30), room: "Hala Sportowa", type: "Sport", weekType: .both),
            
            ScheduleEntity(id: UUID(), subjectId: subj_bot.id, groupId: group_isp31.id, teacherId: t_volt.id, dayOfWeek: 3, startTime: baseDate.withTime(hour: 8, minute: 05), endTime: baseDate.withTime(hour: 9, minute: 35), room: "281A", type: "Lection", weekType: .even),
            ScheduleEntity(id: UUID(), subjectId: subj_prog.id, groupId: group_isp31.id, teacherId: t_plato.id, dayOfWeek: 3, startTime: baseDate.withTime(hour: 8, minute: 00), endTime: baseDate.withTime(hour: 9, minute: 30), room: "134T", type: "Lection", weekType: .odd),
            ScheduleEntity(id: UUID(), subjectId: subj_net.id, groupId: group_isp31.id, teacherId: t_plato.id, dayOfWeek: 3, startTime: baseDate.withTime(hour: 9, minute: 45), endTime: baseDate.withTime(hour: 11, minute: 15), room: "134T", type: "Lection", weekType: .both),
            ScheduleEntity(id: UUID(), subjectId: subj_pms.id, groupId: group_isp31.id, teacherId: t_codd.id, dayOfWeek: 3, startTime: baseDate.withTime(hour: 12, minute: 15), endTime: baseDate.withTime(hour: 13, minute: 45), room: "B573", type: "Computer", weekType: .both),
            
            ScheduleEntity(id: UUID(), subjectId: subj_bot.id, groupId: group_isp31.id, teacherId: t_dijkstra.id, dayOfWeek: 4, startTime: baseDate.withTime(hour: 13, minute: 00), endTime: baseDate.withTime(hour: 14, minute: 30), room: "B153", type: "Practice", weekType: .both),
            
            ScheduleEntity(id: UUID(), subjectId: subj_prog.id, groupId: group_isp31.id, teacherId: t_armstrong.id, dayOfWeek: 5, startTime: baseDate.withTime(hour: 8, minute: 30), endTime: baseDate.withTime(hour: 10, minute: 00), room: "A172", type: "Practice", weekType: .even),
            ScheduleEntity(id: UUID(), subjectId: subj_engl.id, groupId: group_isp31.id, teacherId: t_herodotus.id, dayOfWeek: 5, startTime: baseDate.withTime(hour: 10, minute: 15), endTime: baseDate.withTime(hour: 11, minute: 55), room: "B201", type: "Practice", weekType: .both),
        ]
        
        let task_prog = TaskEntity(id: UUID(), subjectId: subj_prog.id, teacherId: t_ada.id, title: "Exam", type: "exam", dueDate: Date())
        let task_bot = TaskEntity(id: UUID(), subjectId: subj_bot.id, teacherId: t_turing.id, title: "Kolokwium", type: "kolokwium", dueDate: Date())
        let task_bog = TaskEntity(id: UUID(), subjectId: subj_bog.id, teacherId: t_euclid.id, title: "Test", type: "test", dueDate: Date())
        let task_databases = TaskEntity(id: UUID(), subjectId: subj_databases.id, teacherId: t_ive.id, title: "Project", type: "project", dueDate: Date())
        self.tasks = [task_prog, task_bot, task_bog, task_databases]
        
        self.grades = [
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_prog.id, markValue: 4, dateGiven: Date()),
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_bot.id, markValue: 5, dateGiven: Date()),
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_bog.id, markValue: 3, dateGiven: Date()),
            GradeEntity(id: UUID(), studentId: mainStudent.id, taskId: task_databases.id, markValue: 5, dateGiven: Date())
        ]
        
        self.news = [
            NewsEntity(id: UUID(), universityId: uni.id, title: "Tech pause", subtitle: "from 8 to 12 pm", content: "\tWe’re taking a short technical break to make your experience even better.\n\tRight now, we’re updating systems, improving performance, and preparing new features. While this work is underway, the app may be unavailable or function with limitations.", date: Date(), imageName: "card_news_1"),
            NewsEntity(id: UUID(), universityId: uni.id, title: "USOS update", subtitle: "version 1.01", content: "\tWe’ve made several improvements to keep the app running smoothly.This update includes performance enhancements, stability fixes, and general bug corrections.\nEnjoy a more reliable experience!", date: Date(), imageName: "card_news_2")
        ]
    }
}
