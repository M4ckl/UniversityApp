import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationStack {
            ZStack {

                BackgroundView()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 48) {
                        VStack(spacing: 12){
                            NavigationLink(destination: ProfileView()) {
                                ProfileCardView()
                            }
                            .buttonStyle(ScaleButtonStyle())
                            QuickActionsView()
                        }
                        ServicesSectionView()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}

