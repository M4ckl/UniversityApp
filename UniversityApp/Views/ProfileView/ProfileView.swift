import SwiftUI

struct ProfileView: View {
    private let db = MockDatabaseService.shared
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Image(db.students.first!.avatarName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
                Text(db.students.first!.fullName)
                    .font(.title.bold())
                    .foregroundColor(Color("MainTextColor"))
                
                Spacer()
            }
            .padding(.top, 50)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
