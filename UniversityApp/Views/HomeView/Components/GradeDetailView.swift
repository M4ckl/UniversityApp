import SwiftUI

struct GradeDetailView: View {
    let grade: GradeModel
    @Environment(\.dismiss) var dismiss

    @State private var showBackground = false
    @State private var showCard = false
    @Environment(\.colorScheme) var colorScheme
    @State private var animatedProgress: CGFloat = 0.0
    @State private var animatedGrade: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {

                Color.black
                    .opacity(showBackground ? 0.4 : 0)
                    .ignoresSafeArea()
                    .onTapGesture { closeWithAnimation() }
                    .animation(.easeInOut(duration: 0.2), value: showBackground)

                ZStack(alignment: .top) {

                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            Button(action: { closeWithAnimation() }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.gray.opacity(0.6))
                                    .padding(8)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                        
                        Spacer().frame(height: 20)
                        
                        VStack(spacing: 8) {
                            HStack(spacing: 8) {
                                Text(grade.subjectName)
                                    .font(.title.bold())
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("MainTextColor"))
                                
                                Text(grade.eventType.uppercased())
                                    .font(.system(size: 12)).bold()
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(20)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            HStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 12)).bold()
                                    .foregroundColor(.gray)
                                Text(grade.teacherName)
                                    .font(.system(size: 12)).bold()
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: { print("Your work") }) {
                                Image(systemName: "list.clipboard")
                                    .font(.system(size: 20)).bold()
                                    .foregroundColor(.red)
                                    .padding(16)
                                    .background(.red.opacity(0.3))
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
                            }.buttonStyle(ScaleButtonStyle())
                            Button(action: { print("Stats") }) {
                                Text("Statistics")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(Color("MainTextColor"))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("BlockColor"))
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                    .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
                            }.buttonStyle(ScaleButtonStyle())
                            Button(action: { print("Appeal") }) {
                                Text("Appeal")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(Color("MainTextColor"))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("BlockColor"))
                                    .cornerRadius(30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                    .shadow(color: .black.opacity(colorScheme == .dark ? 0.2 : 0.05), radius: 10, y: 5)
                            }.buttonStyle(ScaleButtonStyle())
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer().frame(height: 16)
                    }
                    .background(Color("EFEFEF"))
                    .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                    .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: -5)
                    ZStack {
                        Circle()
                            .fill(Color("EFEFEF"))
                            .frame(width: 130, height: 130)

                        GradeProgressRing(
                            progress: animatedProgress,
                            color: grade.color,
                            grade: animatedGrade,
                            
                            size: 100,
                            lineWidth: 10,
                            fontSize: 50
                        )
                    }
                    .offset(y: -35)
                    
                }
                .padding(.top, 65)
                .offset(y: showCard ? 0 : proxy.size.height)
                
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                showBackground = true
            }
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                showCard = true
            }
            withAnimation(.easeOut(duration: 1.5).delay(0.2)) {
                animatedProgress = grade.progress
                animatedGrade = CGFloat(grade.gradeValue)
            }
        }
    }
    
    private func closeWithAnimation() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            showCard = false
        }
        withAnimation(.easeOut(duration: 0.3)) {
            showBackground = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            dismiss()
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
