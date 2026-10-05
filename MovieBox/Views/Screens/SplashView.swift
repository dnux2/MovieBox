import SwiftUI

// شاشة البداية: اللوقو يظهر بحركة خفيفة
struct SplashView: View {
    @State private var appeared = false

    var body: some View {
        ZStack {
            AppBackground()

            VStack(spacing: 16) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                    .scaleEffect(appeared ? 1 : 0.7)

                Text("Seen")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
            }
            .opacity(appeared ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                appeared = true
            }
        }
    }
}

#Preview {
    SplashView()
}
