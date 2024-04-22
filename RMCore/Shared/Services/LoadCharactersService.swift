import Foundation

public protocol LoadCharactersService {
    func loadCharacters(pageNumber: Int) async throws -> [Character]
}
