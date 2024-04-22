import Foundation

final class GetCharactersListRequest: HTTPRequest {
    var method: HTTPMethod = .get
    var path: String = "/api/character"
    var queryItems: [URLQueryItem] = []
    var body: Data?
    
    func addQueryItem(name: String, value: String?) -> GetCharactersListRequest {
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        return self
    }
}
