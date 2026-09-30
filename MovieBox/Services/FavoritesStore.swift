import Foundation
import Observation

// يحفظ الأفلام المفضلة في UserDefaults عشان تبقى بعد ما أقفل التطبيق
@MainActor
@Observable
final class FavoritesStore {

    private let key = "favoriteMovies"
    private(set) var movies: [Movie] = []

    init() {
        load()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        movies.contains { $0.id == movie.id }
    }

    // لو موجود أشيله، ولو مو موجود أضيفه في الأول
    func toggle(_ movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies.remove(at: index)
        } else {
            movies.insert(movie, at: 0)
        }
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode([Movie].self, from: data) else {
            return
        }
        movies = saved
    }
}
