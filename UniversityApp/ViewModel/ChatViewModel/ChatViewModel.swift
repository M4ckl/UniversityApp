import SwiftUI
import Combine

public enum FilterType: String, CaseIterable, Hashable {
    case all = "All"
    case students = "Students"
    case lektors = "Lecturers"
    public var iconName: String { switch self{case .all,.students,.lektors: return "folder.fill"}}
    public var selectedIconName: String { switch self{case .all,.students,.lektors: return "folder.fill"}}
}

class ChatViewModel: ObservableObject {
    @Published var selectedFilter: FilterType = .all
    @Published var filteredChats: [ChatRoomModel] = []
    @Published var selectedChat: ChatRoomModel? = nil
    
    var allChats: [ChatRoomModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private let db = MockDatabaseService.shared
    
    init() {
        print("ChatViewModel init()")
        loadData()
        setupSubscribers()
    }
    
    func loadData() {
        print("loadData() started")
        let now = AppContext.now()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        
        let allLektors = db.teachers.map { $0.toLektorModel(subjects: db.subjects) }
        let otherStudents = db.students
            .filter { $0.id != db.mainStudent.id }
            .map { $0.toStudentModel() }
        
        guard let chatWithStudent = otherStudents.first,
              let chatWithLektor = allLektors.first
        else {
            print("Not enough data to create mock chats")
            return
        }
        
        self.allChats = [
            ChatRoomModel(id: UUID(),
                          participant: .student(chatWithStudent),
                          lastMessage: "hi from student",
                          lastMessageTimestamp: yesterday,
                          status: .read,
                          unreadCount: 0,
                          isLastMessageFromCurrentUser: true),
            
            ChatRoomModel(id: UUID(),
                          participant: .lektor(chatWithLektor),
                          lastMessage: "great app from lecturer",
                          lastMessageTimestamp: now,
                          status: .incomingUnread,
                          unreadCount: 1,
                          isLastMessageFromCurrentUser: false)
        ]
        print("Loaded \(allChats.count) chats total.")
        
        filterChats()
    }
    
    private func setupSubscribers() {
        $selectedFilter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] filterValue in
                guard let self = self else { return }
                print("➡️ Filter changed via .sink: \(filterValue)")
                self.filterChats()
            }
            .store(in: &cancellables)
        print("Subscribers setup.")
    }

    func selectFilter(_ filter: FilterType) {
        guard filter != selectedFilter else {
            print("⚠️ Tapped same filter (\(filter)), no change needed.")
            return
        }
        print("✅ selectFilter called with: \(filter)")
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            selectedFilter = filter
        }
    }

    func filterChats() {
        print("--- ⚙️ filterChats() running for selectedFilter = \(selectedFilter) ---")
        print("   Raw allChats: \(allChats.map { $0.participant.isStudent ? "Student (\($0.participant.fullName))" : "Lecturer (\($0.participant.fullName))" })")

        let result: [ChatRoomModel]
        switch selectedFilter {
        case .all:
            result = allChats
            print("   Filtering logic: Case .all matched.")
        case .students:
            result = allChats.filter { $0.participant.isStudent }
            print("   Filtering logic: Case .students matched.")
        case .lektors:
            result = allChats.filter { $0.participant.isLektor }
            print("   Filtering logic: Case .lektors matched.")
        }
        print("   Filtering result count: \(result.count)")
        print("   Filtered result participants: \(result.map { $0.participant.fullName })")

        DispatchQueue.main.async {
            self.filteredChats = result
            print("   ✅ Updated @Published filteredChats.")
            print("---------------------------------------")
        }
    }

     func markChatAsRead(chatId: UUID) { if let index = allChats.firstIndex(where: { $0.id == chatId }), !allChats[index].isLastMessageFromCurrentUser { allChats[index].status = .idle; allChats[index].unreadCount = 0; filterChats() } }
     func updateChatReadStatus(chatId: UUID, status: MessageStatus) { if let index = allChats.firstIndex(where: { $0.id == chatId }), allChats[index].isLastMessageFromCurrentUser { allChats[index].status = status; filterChats() } }
}
