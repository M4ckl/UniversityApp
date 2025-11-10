import Testing
@testable import UniversityApp

@MainActor
struct UniversityAppTests {

    @Test func testChatFilterLogic() async throws {
        let viewModel = ChatViewModel()
        
        #expect(viewModel.filteredChats.count == 2, "Initial 'All' filter should show 2 chats")
        
        viewModel.selectFilter(.students)
        try await Task.sleep(nanoseconds: 1_000_000)
        
        #expect(viewModel.filteredChats.count == 1, "'Students' filter should show 1 chat")
        let isStudent = viewModel.filteredChats.first?.participant.isStudent ?? false
        #expect(isStudent == true, "The only chat in 'Students' should belong to a student")

        viewModel.selectFilter(.lektors)
        try await Task.sleep(nanoseconds: 1_000_000)
        
        #expect(viewModel.filteredChats.count == 1, "'Lektors' filter should show 1 chat")
        let isLektor = viewModel.filteredChats.first?.participant.isLektor ?? false
        #expect(isLektor == true, "The only chat in 'Lektors' should belong to a lecturer")

        viewModel.selectFilter(.all)
        try await Task.sleep(nanoseconds: 1_000_000)
        
        #expect(viewModel.filteredChats.count == 2, "'All' filter should show 2 chats again")
    }
}
