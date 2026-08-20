import Foundation

public final class LoadCharactersServiceImplementation: LoadCharactersService {
    let networkSession: NetworkSession

    public init(networkSession: NetworkSession = NetworkSessionImplementation()) {
        self.networkSession = networkSession
    }

    public func loadCharacters(pageNumber: Int) async throws -> CharacterResponse {
        let request = GetCharactersListRequest()
            .addQueryItem(name: "page", value: String(pageNumber))
        let responseData = try await networkSession.request(request)
        do {
            return try JSONDecoder().decode(CharacterResponse.self, from: responseData)
        } catch {
            throw RMCoreBusinessErrorFactory.mapError(code: .failedToDecode)
        }
    }
}
