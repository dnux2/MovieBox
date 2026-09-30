
import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
}
