import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                if viewModel.filteredResults.isEmpty && !viewModel.searchText.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchText)
                }
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.filteredResults) { item in
                            SearchResultRow(item: item)
                                .onTapGesture {
                                    viewModel.selectedItem = item
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Search")
                        .font(.title2.bold())
                        .foregroundStyle(Color("MainTextColor"))
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search")
        .sheet(item: $viewModel.selectedItem) { item in
            SearchResultDetailView(item: item)
        }
    }
}

struct SearchResultRow: View {
    let item: SearchableItem
    
    var body: some View {
        HStack(spacing: 12) {
            if item.isSFSymbol {
                Image(systemName: item.iconName)
                    .font(.title3)
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.secondary)
            } else {
                Image(item.iconName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .if(!item.isSubject) { view in
                        view.clipShape(Circle())
                    }
            }
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .background(Color("BlockColor"))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


