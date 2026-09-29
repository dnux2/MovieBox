

import Foundation


enum Config {
    static var tmdbToken: String {
        Bundle.main.object(forInfoDictionaryKey: "TMDB_TOKEN") as? String ?? ""
    }
}
