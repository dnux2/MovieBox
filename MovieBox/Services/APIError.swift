import Foundation

//الLocalizedError
//بروتوكول يخلي الخطأ عنده نص جاهز للعرض
enum APIError: LocalizedError {
    case invalidURL
    case noConnection
    case invalidResponse
    //هنا يعطيني رقم الغلط مثل ٤٠٤ ولا٥٠٠
    case serverError(Int)
    //لما الجيسون مايطابق المودل الي عندي
    case decodingFailed

    //الرسايل الي تنعرض عالشاشه
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noConnection:
            return "No internet connection. Check your network and try again."
        case .invalidResponse:
            return "Unexpected response from the server."
        //يطبع رقم الغلط مثل ٤٠٤
        case .serverError(let code):
            return "Server error (\(code))."
        case .decodingFailed:
            return "Couldn't read the data from the server."
        }
    }
}
