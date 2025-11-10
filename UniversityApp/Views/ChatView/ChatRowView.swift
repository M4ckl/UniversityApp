import SwiftUI

struct ChatRowView: View {
    let chat: ChatRoomModel

    var body: some View {
        HStack(spacing: 12) {
            Image(chat.participant.avatarName)
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(chat.participant.fullName)
                    .font(.headline)
                    .foregroundColor(Color("MainTextColor"))
                Text(chat.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }

            Spacer()
            VStack(alignment: .trailing, spacing: 5) {
                HStack(spacing: 4) {
                    if chat.isLastMessageFromCurrentUser {
                        Image(systemName: chat.status == .read ? "checkmark.done" : "checkmark")
                            .font(.system(size: 14))
                            .foregroundColor(chat.status == .read ? .red : .gray)
                    }
                    Text(chat.formattedTimestamp)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                if chat.status == .incomingUnread && chat.unreadCount > 0 {
                    Text("\(chat.unreadCount)")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .padding(5)
                        .frame(minWidth: 22, minHeight: 22)
                        .background(Color.red)
                        .clipShape(Circle())
                } else {
                    Circle().fill(Color.clear).frame(width: 22, height: 22)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color("202020"))
    }
}

