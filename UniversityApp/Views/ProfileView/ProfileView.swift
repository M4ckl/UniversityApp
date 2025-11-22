import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.colorScheme) var colorScheme

    @State private var showQRCode = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        VStack(spacing: 12) {
                            Image(viewModel.studentAvatar)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                            VStack(spacing: 4) {
                                Text(viewModel.studentName)
                                    .font(.title2.bold())
                                    .foregroundColor(Color("MainTextColor"))
                                
                                Text("ID: \(viewModel.studentID)")
                                    .font(.caption.monospaced())
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(20)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.top, 20)

                        VStack(spacing: 16) {
                            ProfileInfoRow(icon: "building.2.fill", title: "Department", value: viewModel.department)
                            Divider()
                            ProfileInfoRow(icon: "book.closed.fill", title: "Program", value: viewModel.program)
                            Divider()
                            HStack {
                                ProfileInfoRow(icon: "graduationcap.fill", title: "Course", value: viewModel.course)
                                Spacer()
                                Text(viewModel.status)
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.green.opacity(0.15))
                                    .cornerRadius(20)
                            }
                        }
                        .padding()
                        .background(Color("BlockColor"))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
                        HStack(spacing: 16) {
                            VStack(alignment: .leading) {
                                Text("Average Grade")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(viewModel.averageGrade)
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(Color.blue)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color("BlockColor"))
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
                            Button(action: { showQRCode.toggle() }) {
                                Image(systemName: "qrcode")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color.black.opacity(0.8))
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                            }.buttonStyle(ScaleButtonStyle())
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Recent Applications")
                                .font(.headline)
                                .foregroundColor(Color("MainTextColor"))
                                .padding(.leading, 4)
                            
                            HStack {
                                Spacer()
                                VStack(spacing: 8) {
                                    Image(systemName: "doc.text.magnifyingglass")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray.opacity(0.5))
                                    Text("Your applications have not been reviewed yet")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.vertical, 24)
                                Spacer()
                            }
                            .background(Color("BlockColor").opacity(0.5))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .foregroundColor(.gray.opacity(0.3))
                            )
                        }
                        VStack(spacing: 12) {
                            ProfileMenuButton(icon: "gearshape.fill", title: "Settings", color: Color("MainTextColor"))
                            ProfileMenuButton(icon: "rectangle.portrait.and.arrow.right", title: "Log Out", color: .red)
                        }
                        
                        Spacer().frame(height: 20)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Text("Edit")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showQRCode) {
                VStack {
                    Text("Student QR Code")
                        .font(.title2.bold())
                    Image(systemName: "qrcode")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                    Text("Scan to verify identity")
                        .foregroundColor(.secondary)
                }
                .presentationDetents([.medium])
            }
        }
    }
}

struct ProfileInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(Color("MainTextColor"))
            }
            Spacer()
        }
    }
}

struct ProfileMenuButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 32)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)
                
                Spacer()
            }
            .padding()
            .background(Color("BlockColor"))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
