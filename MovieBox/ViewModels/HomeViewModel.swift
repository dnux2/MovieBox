import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {

    private let movieService = MovieService()

    var movies: [Movie] = []
    var isLoading = true          
    var errorMessage: String?

    func fetchMovies() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await movieService.popularMovies()
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
