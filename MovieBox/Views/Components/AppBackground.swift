import SwiftUI

struct AppBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    private var colors: [Color] {
        if colorScheme == .dark {
            return [.blue, .black, .blue, .black]
        } else {
            return [
                Color.blue.opacity(0.35),
                Color(.systemBackground),
                Color.blue.opacity(0.35),
                Color(.systemBackground)
            ]
        }
    }

    var body: some View {
        LinearGradient(colors: colors, startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea()
    }
}
