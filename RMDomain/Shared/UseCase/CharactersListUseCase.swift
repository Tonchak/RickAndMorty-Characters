import Foundation
import RMCore

public protocol CharactersListUseCase {
    func getCharactersByPage(_ pageNumber: Int) async throws -> [CharacterEntityProtocol]
}

public final class DefaultCharactersListUseCase: CharactersListUseCase {
    private let repository: any RMRepository

    public init(repository: any RMRepository = RMRepositoryImplementation(service: LoadCharactersServiceImplementation())) {
        self.repository = repository
    }

    public func getCharactersByPage(_ pageNumber: Int) async throws -> [CharacterEntityProtocol] {
        do {
            let items = try await self.repository.fetchCharacters(pageNumber: pageNumber)
            let result: [CharacterEntityProtocol] = items.map {
                CharacterEntity(decodable: $0 as! Character)
            }
            return result
        } catch {
            throw error
        }
    }
}
