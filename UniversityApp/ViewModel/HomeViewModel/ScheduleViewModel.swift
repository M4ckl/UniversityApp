import SwiftUI
import Combine

class ScheduleViewModel: ObservableObject {
    
    @Published var scheduleItems: [ScheduleItemModel] = []
    @Published var dayTitle: String = ""
    @Published var dateString: String = ""

    private let scheduleService = MockScheduleService.shared
    
    init() {
        loadData()
    }
    
    func loadData() {
        let today = AppContext.now()
        
        self.dayTitle = today.dayOfWeek
        self.dateString = today.longDate

        let lessons = scheduleService.getLessons(for: today)

        self.scheduleItems = lessons.map { $0.toScheduleItemModel(now: today) }
    }
}
