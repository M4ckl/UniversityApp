import SwiftUI
import Combine

class ConversationViewModel: ObservableObject {
    @Published var messages: [MessageModel] = []
    @Published var inputText: String = ""
    @Published var showingAttachmentOptions: Bool = false
    let chatRoom: ChatRoomModel
    weak var chatListViewModel: ChatViewModel?

    init(chatRoom: ChatRoomModel, chatListViewModel: ChatViewModel? = nil) {
        self.chatRoom = chatRoom
        self.chatListViewModel = chatListViewModel
        loadInitialMessages()
    }

    func loadInitialMessages() {
        if chatRoom.status == .incomingUnread {
            messages = [
                MessageModel(text: chatRoom.lastMessage, timestamp: chatRoom.lastMessageTimestamp, isFromCurrentUser: false)
            ]
        } else if chatRoom.isLastMessageFromCurrentUser {
             messages = [
                 MessageModel(text: chatRoom.lastMessage, timestamp: chatRoom.lastMessageTimestamp, isFromCurrentUser: true)
             ]
        }
    }

    func sendMessage() {
        let trimmedText = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        let newMessage = MessageModel(text: trimmedText, timestamp: Date(), isFromCurrentUser: true)
        messages.append(newMessage)
        inputText = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.simulateReply()
            self?.simulateMarkingAsRead(messageId: newMessage.id)
        }
    }

    private func simulateReply() {
        let reply = MessageModel(text: "Hello!", timestamp: Date(), isFromCurrentUser: false)
        messages.append(reply)
    }

    private func simulateMarkingAsRead(messageId: UUID) {
         if let index = chatListViewModel?.allChats.firstIndex(where: { $0.id == chatRoom.id }),
            chatListViewModel?.allChats[index].isLastMessageFromCurrentUser == true {
             DispatchQueue.main.async {
                 self.chatListViewModel?.allChats[index].status = .read
                 self.chatListViewModel?.filterChats()
             }
        }
    }

    func markConversationAsRead() {
        if let index = chatListViewModel?.allChats.firstIndex(where: { $0.id == chatRoom.id }) {
            if !chatListViewModel!.allChats[index].isLastMessageFromCurrentUser {
                 DispatchQueue.main.async {
                     self.chatListViewModel?.allChats[index].status = .idle
                     self.chatListViewModel?.allChats[index].unreadCount = 0
                     self.chatListViewModel?.filterChats()
                 }
            }
        }
         print("Marking conversation \(chatRoom.id) as read")
    }
}
