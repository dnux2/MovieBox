import Foundation

// هنا دوال الأفلام بأسماء واضحة، الـ ViewModel يناديها
// وما يحتاج يعرف شي عن الروابط أو الـ endpoints
struct MovieService {
    private let client: APIClient

    init(client: APIClient = APIClient()) {
        self.client = client
    }

    // الأفلام الرائجة، لصفحة Home
    func popularMovies(page: Int = 1) async throws -> MovieListResponse {
        try await client.get("/movie/popular", queryItems: [
            URLQueryItem(name: "page", value: String(page))
        ])
    }

    // البحث بالاسم، لصفحة Search
    func searchMovies(query: String, page: Int = 1) async throws -> MovieListResponse {
        try await client.get("/search/movie", queryItems: [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page))
        ])
    }

    // تفاصيل فيلم واحد، لصفحة Detail
    func movieDetail(id: Int) async throws -> MovieDetail {
        try await client.get("/movie/\(id)")
    }
}
