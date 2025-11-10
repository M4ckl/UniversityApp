import Foundation

struct MessageModel: Identifiable {
    let id = UUID()
    let text: String
    let timestamp: Date
    let isFromCurrentUser: Bool
}
