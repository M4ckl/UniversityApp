import Foundation

struct NewsEntity: Identifiable {
    let id: UUID
    var universityId: UUID
    var title: String
    var subtitle: String
    var content: String
    var date: Date
    var imageName: String
}
