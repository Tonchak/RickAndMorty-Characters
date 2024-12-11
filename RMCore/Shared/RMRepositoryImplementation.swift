import Foundation

public final class RMRepositoryImplementation: RMRepository {

    public typealias Item = Character
    public typealias Service = LoadCharactersService

    let service: Service

    required public init(service: Service) {
        self.service = service
    }

    public func fetchCharacters(pageNumber: Int) async throws -> [Character] {
        try await service.loadCharacters(pageNumber: pageNumber)
    }
}
