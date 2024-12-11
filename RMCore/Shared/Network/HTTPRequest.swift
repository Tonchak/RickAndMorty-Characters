import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public protocol HTTPRequest {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var body: Data? { get }
}

extension HTTPRequest {
    func url(hostName: String) -> URL? {
        var components = URLComponents()

        let baseURL = URLComponents(string: hostName)
        components.scheme = baseURL?.scheme
        components.host = baseURL?.host
        components.port = baseURL?.port
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
