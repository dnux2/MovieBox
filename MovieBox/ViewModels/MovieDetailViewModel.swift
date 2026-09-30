import Foundation
import Observation

@MainActor
@Observable
final class MovieDetailViewModel {

    private let movieService = MovieService()
    private let movieID: Int

    var detail: MovieDetail?
    var isLoading = true
    var errorMessage: String?

    init(movieID: Int) {
        self.movieID = movieID
    }

    func fetchDetail() async {
        isLoading = true
        errorMessage = nil

        do {
            detail = try await movieService.movieDetail(id: movieID)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
