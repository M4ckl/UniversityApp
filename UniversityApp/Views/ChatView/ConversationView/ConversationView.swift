import SwiftUI

struct ConversationView: View {
    @StateObject private var viewModel: ConversationViewModel
    @EnvironmentObject var chatListViewModel: ChatViewModel 

    @FocusState private var isTextFieldFocused: Bool

    init(chat: ChatRoomModel) {
        _viewModel = StateObject(wrappedValue: ConversationViewModel(chatRoom: chat))
    }

    var body: some View {
        ZStack {
            BackgroundView()

            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                MessageBubbleView(message: message)
                                    .id(message.id)
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                    .onAppear {
                        scrollToBottom(proxy: proxy, animated: false)
                        viewModel.markConversationAsRead()
                    }
                    .onChange(of: viewModel.messages.count) {
                         scrollToBottom(proxy: proxy, animated: true)
                    }
                    .onTapGesture {
                        isTextFieldFocused = false
                    }

                }
                GlassEffectContainer{
                    HStack(alignment: .bottom, spacing: 8) {
                        Button {
                            viewModel.showingAttachmentOptions = true
                            isTextFieldFocused = false
                            } label: {
                                Image(systemName: "paperclip")
                                    .foregroundStyle(Color.gray)
                                    .frame(width: 16, height: 24)
                            }.buttonStyle(.glass)

                        TextField("Message", text: $viewModel.inputText, axis: .vertical)
                            .lineLimit(1...5)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .clipShape(Capsule())
                            .focused($isTextFieldFocused)
                            .glassEffect()
                        Button(action: viewModel.sendMessage) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.title)
                                .frame(width: 16, height: 24)
                                .foregroundColor(viewModel.inputText.isEmpty ? Color(.systemGray3) : Color.blue)
                                .animation(.easeInOut(duration: 0.2), value: viewModel.inputText.isEmpty)
                        }
                        .disabled(viewModel.inputText.isEmpty)
                        .buttonStyle(.glass)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack{
                    Text(viewModel.chatRoom.participant.fullName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color("MainTextColor"))
                    Image(viewModel.chatRoom.participant.avatarName)
                        .resizable().scaledToFit().frame(width: 30, height: 30)
                        .clipShape(Circle())
                }.padding(.horizontal,4)
            }
        }
        .animation(.default, value: viewModel.messages.count)
        .confirmationDialog("Attach File", isPresented: $viewModel.showingAttachmentOptions, titleVisibility: .visible) {
             Button("Photo Library") { /* TODO: Implement photo picker */ }
             Button("Files") { /* TODO: Implement file picker */ }
             Button("Cancel", role: .cancel) {}
         } message: {
             Text("Choose source")
         }
    
    }
    private func scrollToBottom(proxy: ScrollViewProxy, animated: Bool) {
        guard let lastMessageId = viewModel.messages.last?.id else { return }
        if animated { withAnimation { proxy.scrollTo(lastMessageId, anchor: .bottom) } }
        else { proxy.scrollTo(lastMessageId, anchor: .bottom) }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStudent = StudentModel(id: UUID(), name: "Student", surname: "Preview", avatarName: "person.fill")
        let participant = ChatParticipant.student(sampleStudent)

        let chat = ChatRoomModel(
            participant: participant,
            lastMessage: "Last message preview",
            lastMessageTimestamp: Date(),
            status: .incomingUnread,
            unreadCount: 2,
            isLastMessageFromCurrentUser: false
        )

        let chatVM = ChatViewModel()

        return ConversationView(chat: chat)
            .environmentObject(chatVM)
            .previewDisplayName("Conversation Preview")
    }
}
