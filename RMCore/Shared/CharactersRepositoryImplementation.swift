import Foundation
import RMDomain

public final class CharactersRepositoryImplementation: CharactersRepository {
    private let service: LoadCharactersService

    public init(service: LoadCharactersService) {
        self.service = service
    }

    public func fetchCharacters(pageNumber: Int) async throws -> [CharacterEntity] {
        let characters = try await service.loadCharacters(pageNumber: pageNumber)
        return characters.map(CharacterEntity.init(dto:))
    }
}
