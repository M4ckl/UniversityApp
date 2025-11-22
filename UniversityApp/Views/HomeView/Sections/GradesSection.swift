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
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.visibleGrades)
        }
        .navigationDestination(isPresented:  $showAllGrades) {
            AllGradesView(grades: viewModel.allGrades)
        }
        .fullScreenCover(item: $viewModel.selectedGrade) { grade in
            GradeDetailView(grade: grade)
                .presentationBackground(.clear)
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
                grade: CGFloat(grade.gradeValue)
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

struct AnimatableNumberModifier: AnimatableModifier {
    var number: CGFloat
    var color: Color
    var fontSize: CGFloat
    
    var animatableData: CGFloat {
        get { number }
        set { number = newValue }
    }
    
    func body(content: Content) -> some View {
        Text("\(Int(number))")
            .font(.system(size: fontSize, weight: .bold))
            .foregroundColor(color)
    }
}

struct GradeProgressRing: View {
    let progress: CGFloat
    let color: Color
    let grade: CGFloat

    var size: CGFloat = 40
    var lineWidth: CGFloat = 4
    var fontSize: CGFloat = 20
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))

            Color.clear
                .modifier(AnimatableNumberModifier(
                    number: grade,
                    color: color,
                    fontSize: fontSize
                ))
        }
        .frame(width: size, height: size)
    }
}
