import Foundation

public struct CharacterResponse: Decodable, Equatable {
    public let info: Info
    public let results: [Character]
    
    enum CodingKeys: String, CodingKey {
        case info
        case results
    }
}
