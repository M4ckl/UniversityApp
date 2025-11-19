import SwiftUI

struct AllGradesView: View {
    let grades: [GradeModel]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(grades) { grade in
                            GradeRow(grade: grade)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("List of Grades")
                        .font(.title3).bold()
                        .foregroundStyle(Color("MainTextColor"))
                }
            }
        }
    }
}
