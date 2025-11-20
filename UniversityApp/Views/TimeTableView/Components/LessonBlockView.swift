import SwiftUI

struct LessonBlockView: View {
    let lesson: LessonModel
    let timeColumnWidth: CGFloat = 70
    let gridPadding: CGFloat = 6
    let onMoreTapped: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .top) {
            Rectangle()
                .fill(lesson.typeColor)
                .frame(width: 4)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(lesson.subjectName)
                        .font(.headline).fontWeight(.bold)
                    Spacer()
                    LessonTag(text: lesson.type, color: lesson.typeColor)
                }
                Text(lesson.teacherName)
                    .font(.subheadline).foregroundColor(.secondary)
                Spacer()
                HStack(alignment: .center) {
                    Text(lesson.classroom)
                        .font(.caption.weight(.medium))
                        .padding(.horizontal, 16)
                        .padding(.vertical,4)
                        .foregroundColor(.red).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.red, lineWidth: 1))
                    Spacer()
                    Button(action: {
                        onMoreTapped()
                    }) {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90)).font(.body.weight(.bold)).foregroundColor(.secondary)
                            .frame(width: 36, height: 36)
                            .background(Color.gray.opacity(0.15)).clipShape(Circle())
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(8)
        }
        .background(Color("BlockColor"))
        .cornerRadius(20)
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.1), radius: 3, y: 2)
        .padding(.leading, timeColumnWidth + gridPadding)
        .padding(.trailing, 12)
    }
}

struct LessonTag: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.caption.weight(.medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundColor(color)
            .background(color.opacity(0.15))
            .cornerRadius(20)
    }
}
