import SwiftUI


struct NewsItemModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String
    let imageName: String
    let subtitleColor: Color
    let fullStory: String
    
    init(id: UUID = UUID(), title: String, subtitle: String, imageName: String, subtitleColor: Color = .red, fullStory: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.subtitleColor = subtitleColor
        self.fullStory = fullStory
    }
}
