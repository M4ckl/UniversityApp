import SwiftUI

struct HomeView: View {
    @Namespace var namespace
    private let db = MockDatabaseService.shared
    
    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack(spacing: 20){
                            GradesSection()
                            Rectangle()
                                .cornerRadius(20)
                                .frame(height: 1.5)
                                .foregroundColor(Color.gray.opacity(0.3))
                                .padding(.horizontal, 32)
                            ScheduleSection()
                            Rectangle()
                                .cornerRadius(20)
                                .frame(height: 1.5)
                                .foregroundColor(Color.gray.opacity(0.3))
                                .padding(.horizontal, 32)
                            NewsSection()
                        }
                        .padding(.vertical, 32)
                        .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack{
                        Text(db.mainStudent.fullName)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color("MainTextColor"))
                            .padding(.leading, 4)
                        Image(db.mainStudent.avatarName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal, 2)
                }
           }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
