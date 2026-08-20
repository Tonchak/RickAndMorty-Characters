import Foundation

public protocol CharactersRepository {
    func fetchCharacters(pageNumber: Int) async throws -> CharactersPage
}
