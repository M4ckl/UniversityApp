import SwiftUI
import Combine

class NewsViewModel: ObservableObject {
    @Environment(\.colorScheme) var colorScheme
    
    @Published var visibleNews: [NewsItemModel] = []
    @Published var selectedNews: NewsItemModel? = nil

    var allNewsList: [NewsItemModel] = []
    
    private let db = MockDatabaseService.shared
    
    init() { loadData() }
    
    func loadData() {
        let allNewsEntities = db.news

        let convertedNews = allNewsEntities.map { news in
            return NewsItemModel(
                id: news.id,
                title: news.title,
                subtitle: news.subtitle,
                imageName: news.imageName,
                subtitleColor: .red,
                fullStory: news.content
            )
        }
        
        self.allNewsList = convertedNews

        self.visibleNews = Array(convertedNews.prefix(1))
    }
}
