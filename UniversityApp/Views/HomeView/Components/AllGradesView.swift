import SwiftUI

struct AllGradesView: View {
    let grades: [GradeModel]
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = GradesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(grades) { grade in
                            Button(action: {
                                var transaction = Transaction()
                                transaction.disablesAnimations = true
                                withTransaction(transaction) {
                                    viewModel.selectedGrade = grade
                                }
                            }) {
                                GradeRow(grade: grade)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
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
            .fullScreenCover(item: $viewModel.selectedGrade) { grade in
                GradeDetailView(grade: grade)
                    .presentationBackground(.clear)
            }
        }
    }
}
