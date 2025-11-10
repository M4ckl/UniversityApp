import SwiftUI
import Combine


class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItemModel] = []
    @Published var selectedNews: NewsItemModel? = nil
    private let db = MockDatabaseService.shared
    
    init() { loadData() }
    
    func loadData() {
        let allNews = db.news

        self.newsItems = allNews.map { news in
            return NewsItemModel(
                id: news.id,
                title: news.title,
                subtitle: news.subtitle,
                imageName: news.imageName,
                subtitleColor: .red,
                fullStory: news.content
            )
        }
    }
}
