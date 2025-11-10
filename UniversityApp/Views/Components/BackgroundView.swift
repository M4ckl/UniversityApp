import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            Image("background_image")
                .resizable(resizingMode: .tile)
                .ignoresSafeArea()
         
            Color("EFEFEF")
                .opacity(colorScheme == .dark ? 0.5 : 0.3)
                .ignoresSafeArea()
        }
    }
}
