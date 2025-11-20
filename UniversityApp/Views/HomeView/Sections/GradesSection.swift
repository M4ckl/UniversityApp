import SwiftUI

struct GradesSection: View {
    
    @StateObject private var viewModel = GradesViewModel()
    @State private var showAllGrades = false
    
    var body: some View {
        VStack(spacing: 8) {
            SectionHeader(title: "Grades", onMoreTapped: {
                showAllGrades = true
            })
            VStack(spacing: 8) {
                ForEach(viewModel.visibleGrades) { grade in
                    Button(action: {
                        viewModel.selectedGrade = grade
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
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.visibleGrades)
        }
        .navigationDestination(isPresented:  $showAllGrades) {
            AllGradesView(grades: viewModel.allGrades)
        }
        .sheet(item: $viewModel.selectedGrade) { grade in
            GradeDetailView(grade: grade)
        }
    }
}

struct GradeRow: View {
    let grade: GradeModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(grade.subjectName)
                    .foregroundStyle(Color("MainTextColor"))
                    .font(.system(size: 18, weight: .semibold))
                
                Text(grade.eventType)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(20)
                    .foregroundColor(.secondary)
            }
            
            Spacer()

            GradeProgressRing(
                progress: grade.progress,
                color: grade.color,
                grade: grade.gradeValue
            )
        }
        .padding(.leading, 12)
        .padding(.trailing, 8)
        .padding(.vertical, 8)
        .background(Color("BlockColor"))
        .cornerRadius(40)
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
    }
}

struct GradeProgressRing: View {
    let progress: CGFloat
    let color: Color
    let grade: Int
    
    private let lineWidth: CGFloat = 4
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            Text("\(grade)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(color)
        }
        .frame(width: 40, height: 40)
    }
}
