import SwiftUI

struct MessageBubbleView: View {
    let message: MessageModel
    let cornerRadius: CGFloat = 16

    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
            }

            Text(message.text)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(message.isFromCurrentUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(message.isFromCurrentUser ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))


            if !message.isFromCurrentUser {
                Spacer()
            }
        }
    }
}
