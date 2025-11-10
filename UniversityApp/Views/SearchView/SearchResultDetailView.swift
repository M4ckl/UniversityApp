import SwiftUI

struct SearchResultDetailView: View {
    let item: SearchableItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                
                Text(item.title)
                    .font(.largeTitle.bold())
                
                Text(item.description)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                switch item {
                case .student(let student):
                    InfoRow(label: "Email", value: student.email)
                    InfoRow(label: "Avatar Code", value: student.avatarName)
                    
                case .teacher(let teacher):
                    InfoRow(label: "Title", value: teacher.academicTitle)
                    InfoRow(label: "Email", value: teacher.email)
                    
                case .subject(let subject):
                    InfoRow(label: "Name", value: subject.name)
                    InfoRow(label: "Credits", value: "\(subject.credits)")
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body.weight(.medium))
        }
    }
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStudent = StudentEntity(
            id: UUID(),
            groupId: UUID(),
            fullName: "John Appleseed",
            email: "john@uni.edu",
            avatarName: "main_student_avatar"
        )
        return SearchResultDetailView(item: .student(sampleStudent))
    }
}

