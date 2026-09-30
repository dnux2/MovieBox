import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {

    private let movieService = MovieService()

    var query = ""
    var movies: [Movie] = []
    var isLoading = false
    var errorMessage: String?

    // النص بدون مسافات زايدة
    var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func search() async {
        let text = trimmedQuery

        // لو الخانة فاضية أنظف كل شي وأطلع
        guard !text.isEmpty else {
            movies = []
            errorMessage = nil
            isLoading = false
            return
        }

        isLoading = true
        errorMessage = nil

        // الـ debounce: أنتظر شوي، ولو المستخدم كتب حرف جديد
        // المهمة هذي تنلغي وتبدأ وحدة جديدة، فما يرسل إلا آخر كتابة
        try? await Task.sleep(for: .milliseconds(400))
        if Task.isCancelled { return }

        do {
            let response = try await movieService.searchMovies(query: text)
            movies = response.results
        } catch {
            // المهمة انلغت لأنه كتب حرف ثاني، مو خطأ حقيقي
            if Task.isCancelled { return }
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
