import SwiftUI
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var filteredResults: [SearchableItem] = []
    @Published var selectedItem: SearchableItem? = nil
    
    private var allSearchableItems: [SearchableItem] = []
    private let db = MockDatabaseService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadAllItems()
        setupSubscriber()
    }

    private func loadAllItems() {
        let students = db.students.map { SearchableItem.student($0) }
        let teachers = db.teachers.map { SearchableItem.teacher($0) }
        let subjects = db.subjects.map { SearchableItem.subject($0) }
        
        allSearchableItems = students + teachers + subjects
    }

    private func setupSubscriber() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] (searchText) in
                self?.filterItems(with: searchText)
            }
            .store(in: &cancellables)
    }

    private func filterItems(with searchText: String) {
        if searchText.isEmpty {
            self.filteredResults = []
        } else {
            self.filteredResults = allSearchableItems.filter {
                $0.title.localizedStandardContains(searchText)
            }
        }
    }
}
