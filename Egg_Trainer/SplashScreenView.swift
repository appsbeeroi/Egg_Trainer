import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Image("program_image_0")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Text("EggTrainer")
                    .font(.system(size: 60, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 5)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                    .opacity(isAnimating ? 1 : 0.6)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                            isAnimating = true
                        }
                    }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
