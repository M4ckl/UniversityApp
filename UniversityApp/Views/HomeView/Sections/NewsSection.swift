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

struct NewsDetailView: View {
    
    let item: NewsItemModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack(alignment: .trailing, spacing: 12) {
                        Text(item.subtitle)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .font(.headline)
                            .foregroundColor(item.subtitleColor)
                            .background(Color("BlockColor"))
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
                        
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 160)
                            .cornerRadius(20)
                            .clipped()
                            .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
                        
                        Text(item.fullStory)
                            .font(.body)
                            .lineSpacing(4)
                            .foregroundColor(Color("MainTextColor"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .cornerRadius(20)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("BlockColor").opacity(0.9))
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black.opacity(0.2), lineWidth: 4)
                                        .blur(radius: 10)
                                        .offset(x: 2, y: 2)
                                }
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            )
                            .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
                    }
                    .padding()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(item.title)
                        .font(.title).bold()
                        .foregroundStyle(Color("MainTextColor"))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14).bold())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
