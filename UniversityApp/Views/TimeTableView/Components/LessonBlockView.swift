import SwiftUI

struct LessonBlockView: View {
    let lesson: LessonModel
    let timeColumnWidth: CGFloat = 70
    let gridPadding: CGFloat = 12
    let onMoreTapped: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(lesson.typeColor)
                .frame(width: 4)
                .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(lesson.subjectName)
                        .font(.system(size: 16, weight: .bold))
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                    LessonTag(text: lesson.type, color: lesson.typeColor)
                }
                Text(lesson.teacherName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Spacer(minLength: 0)
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
                            .rotationEffect(.degrees(90))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(width: 24, height: 24)
                            .background(Color.gray.opacity(0.15)).clipShape(Circle())
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(6)
        }
        .background(Color("BlockColor"))
        .cornerRadius(20)
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.1), radius: 3, y: 2)
        .padding(.leading, timeColumnWidth + 6)
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
