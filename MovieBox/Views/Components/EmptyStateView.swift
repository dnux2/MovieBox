import SwiftUI

// سميته EmptyStateView لأن EmptyView اسم جاهز في SwiftUI
struct EmptyStateView: View {
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "film")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(message)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(message: "No movies found.")
}
