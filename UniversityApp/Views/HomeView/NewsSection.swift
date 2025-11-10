import SwiftUI

struct NewsSection: View {
    
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            SectionHeader(title: "News")
  
            if viewModel.newsItems.isEmpty {
                EmptyNewsView()
            } else {
                VStack(spacing: 12) {
                    ForEach(viewModel.newsItems) { item in
                        NewsRow(item: item)
                            .onTapGesture {
                                // При нажатии - "выбираем" новость
                                viewModel.selectedNews = item
                            }
                    }
                }
            }
        }
        .sheet(item: $viewModel.selectedNews) { newsItem in
            NewsDetailView(item: newsItem)
        }
    }
}

struct NewsRow: View {
    let item: NewsItemModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("MainTextColor"))
                Text(item.subtitle)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.5) : item.subtitleColor)
            }
        }
        .padding()
        .background(Color("BlockColor").opacity(0.5))
        .background(
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
        )
        
        .cornerRadius(20)
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
    }
}

struct EmptyNewsView: View {
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "newspaper")
                .font(.system(size: 30))
                .foregroundColor(.gray.opacity(0.7))
            
            Text("No news for today")
                .font(.headline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("BlockColor"))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
    }
}

struct NewsDetailView: View {
    
    let item: NewsItemModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.subtitle)
                        .font(.headline)
                        .foregroundColor(item.subtitleColor)
                    
                    Text(item.fullStory)
                        .font(.body)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                }
            }
        }
    }
}
