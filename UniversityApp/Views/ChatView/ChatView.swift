import SwiftUI

struct ChatView: View {

    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color("202020"))
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .top)
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                        Section {
                            ForEach(viewModel.filteredChats) { chat in
                                ChatRowView(chat: chat)
                                    .onTapGesture { viewModel.selectedChat = chat }
                                Divider().padding(.leading, 80)
                            }
                        } header: {
                            ChatFilterHeaderView(selectedFilter: $viewModel.selectedFilter)
                        }
                    }
                }
                .background(Color("202020"))
            }
            .toolbar {
                 ToolbarItem(placement: .topBarLeading) { Button("Edit") { }.padding(.horizontal, 16).foregroundColor(.red) }
                 ToolbarItem(placement: .topBarTrailing) { Button { } label: { Image(systemName: "plus").foregroundColor(.red) }.buttonStyle(.plain) }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("202020"), for: .navigationBar)
            .navigationDestination(item: $viewModel.selectedChat) { chat in
                ConversationView(chat: chat)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
