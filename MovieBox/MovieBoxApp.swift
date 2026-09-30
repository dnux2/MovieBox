import SwiftUI

@main
struct MovieBoxApp: App {
    @State private var favorites = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(favorites)
        }
    }
}
