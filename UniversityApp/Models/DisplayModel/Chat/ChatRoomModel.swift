import Foundation

struct ChatRoomModel: Identifiable, Hashable {
    static func == (lhs: ChatRoomModel, rhs: ChatRoomModel) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }

    let id: UUID
    let participant: ChatParticipant
    var lastMessage: String
    var lastMessageTimestamp: Date
    var status: MessageStatus
    var unreadCount: Int
    var isLastMessageFromCurrentUser: Bool

    var formattedTimestamp: String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(lastMessageTimestamp) {
            formatter.dateFormat = "HH:mm"
        } else {
            formatter.dateFormat = "dd/MM"
        }
        return formatter.string(from: lastMessageTimestamp)
    }

    init(id: UUID = UUID(), participant: ChatParticipant, lastMessage: String,
         lastMessageTimestamp: Date, status: MessageStatus, unreadCount: Int,
         isLastMessageFromCurrentUser: Bool) {
        self.id = id
        self.participant = participant
        self.lastMessage = lastMessage
        self.lastMessageTimestamp = lastMessageTimestamp
        self.status = status
        self.unreadCount = unreadCount
        self.isLastMessageFromCurrentUser = isLastMessageFromCurrentUser
    }
}
