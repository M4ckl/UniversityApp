import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house" ){
                HomeView()
            }
            
            Tab("Timetable", systemImage: "tablecells" ){
                TimetableView()
            }
            
            Tab("Chat", systemImage: "bubble.left.and.bubble.right" ){
                ChatView()
            }
            
            Tab("More", systemImage: "xmark.triangle.circle.square" ){
                MoreView()
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                SearchView()
            }
        }
        .tint(Color.red)
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
