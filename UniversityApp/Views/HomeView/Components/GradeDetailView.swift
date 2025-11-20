import SwiftUI

struct GradeDetailView: View {
    let grade: GradeModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack(spacing: 24) {
                    GradeProgressRing(
                        progress: grade.progress,
                        color: grade.color,
                        grade: grade.gradeValue
                    )
                    .scaleEffect(3.0)
                    .padding(.vertical, 40)
                    
                    VStack(spacing: 8) {
                        Text(grade.subjectName)
                            .font(.title.bold())
                            .foregroundColor(Color("MainTextColor"))
                        
                        Text(grade.eventType.uppercased())
                            .font(.headline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Grade Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .presentationDetents([.medium])
    }
}
