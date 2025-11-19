import SwiftUI

struct AllNewsView: View {
    let newsList: [NewsItemModel]
    @Environment(\.dismiss) var dismiss

    @State private var selectedNewsItem: NewsItemModel?
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(newsList) { item in
                            NewsRow(item: item)
                                .onTapGesture {
                                    selectedNewsItem = item
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("All News")
                        .font(.title3).bold()
                        .foregroundStyle(Color("MainTextColor"))
                }
            }
            .sheet(item: $selectedNewsItem) { item in
                NewsDetailView(item: item)
                    .presentationDetents([.fraction(0.6)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
