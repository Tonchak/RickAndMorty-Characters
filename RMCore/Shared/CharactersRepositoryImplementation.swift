import Foundation
import RMDomain

public final class CharactersRepositoryImplementation: CharactersRepository {
    private let service: LoadCharactersService

    public init(service: LoadCharactersService) {
        self.service = service
    }

    public func fetchCharacters(pageNumber: Int) async throws -> CharactersPage {
        let response = try await service.loadCharacters(pageNumber: pageNumber)
        return CharactersPage(
            characters: response.results.map(CharacterEntity.init(dto:)),
            nextPageNumber: response.info.next == nil ? nil : pageNumber + 1
        )
    }
}
