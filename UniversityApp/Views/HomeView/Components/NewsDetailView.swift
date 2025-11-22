import SwiftUI

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
