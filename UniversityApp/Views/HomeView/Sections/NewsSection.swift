import SwiftUI

struct NewsSection: View {
    
    @StateObject private var viewModel = NewsViewModel()
    @State private var showAllNews = false
    
    var body: some View {
        VStack(spacing: 12) {

            SectionHeader(title: "News", onMoreTapped: {
                print("More tapped")
                showAllNews = true
            })

            if viewModel.visibleNews.isEmpty {
                EmptyNewsView()
            } else {
                VStack(spacing: 12) {
                    ForEach(viewModel.visibleNews) { item in
                        Button(action: {
                            viewModel.selectedNews = item
                        }) {
                            NewsRow(item: item)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showAllNews) {
            AllNewsView(newsList: viewModel.allNewsList)
        }
        .sheet(item: $viewModel.selectedNews) { item in
            NewsDetailView(item: item)
                .presentationDetents([.fraction(0.7)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct NewsRow: View {
    let item: NewsItemModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("MainTextColor"))
                Text(item.subtitle)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.5) : item.subtitleColor)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("BlockColor").opacity(0.5))
        .background(
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .cornerRadius(20)
        .clipped()
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
        .contentShape(Rectangle())
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
        .background(Color("BlockColor").opacity(0.5))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
    }
}
