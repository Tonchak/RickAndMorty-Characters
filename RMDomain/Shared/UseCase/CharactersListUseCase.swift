import Foundation

public protocol CharactersListUseCase {
    func getCharactersByPage(_ pageNumber: Int) async throws -> CharactersPage
}

public final class DefaultCharactersListUseCase: CharactersListUseCase {
    private let repository: CharactersRepository

    public init(repository: CharactersRepository) {
        self.repository = repository
    }

    public func getCharactersByPage(_ pageNumber: Int) async throws -> CharactersPage {
        try await repository.fetchCharacters(pageNumber: pageNumber)
    }
}
