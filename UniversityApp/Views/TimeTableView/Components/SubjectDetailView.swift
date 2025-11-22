import SwiftUI

struct SubjectDetailView: View {
    let lesson: LessonModel
    let onClose: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isAppearing = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { onClose() }
            VStack(spacing: 24) {
                HStack(alignment: .top) {
                    if lesson.iconName.contains(".") {
                        Image(systemName: lesson.iconName)
                            .font(.largeTitle)
                            .foregroundColor(lesson.typeColor)
                            .frame(width: 60, height: 60)
                            .background(lesson.typeColor.opacity(0.1))
                            .clipShape(Circle())
                    } else {
                        Image(lesson.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(lesson.subjectName)
                            .font(.title2.bold())
                            .foregroundColor(Color("MainTextColor"))
                        Text(lesson.type)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                
                Divider()
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        DetailRow(icon: "person.fill", title: "Teacher", value: lesson.teacherName)
                        
                        Spacer()

                        Button(action: { print("Contact teacher tapped") }) {
                            HStack(spacing: 6) {
                                Text("Contact")
                                    .font(.caption.weight(.bold))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundColor(Color("MainTextColor").opacity(0.8))
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    DetailRow(icon: "clock.fill", title: "Time", value: "\(formatTime(lesson.startTime)) - \(formatTime(lesson.endTime))")
                }
                
                Divider()
                HStack(spacing: 12) {

                    Button(action: { print("Map to \(lesson.classroom) tapped") }) {
                        HStack {
                            Image(systemName: "map.fill")
                            Text("Map to \(lesson.classroom)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(30)
                    }
                    .buttonStyle(ScaleButtonStyle())

                    Button(action: { print("About tapped") }) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                            Text("About")
                        }
                        .font(.headline)
                        .foregroundColor(Color("MainTextColor"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.gray.opacity(0.1))
                                .shadow(
                                    color: .black.opacity(colorScheme == .dark ? 0.2 : 0.2),
                                    radius: 3,
                                    y: 2
                                )
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(24)
            .background(Color("BlockColor"))
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 20)
            .scaleEffect(isAppearing ? 1.0 : 0.9)
            .opacity(isAppearing ? 1.0 : 0.0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                isAppearing = true
            }
        }
        .zIndex(100)
    }
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.gray)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body.weight(.medium))
                    .foregroundColor(Color("MainTextColor"))
            }
        }
    }
}
