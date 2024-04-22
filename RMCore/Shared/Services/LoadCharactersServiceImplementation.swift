import Foundation

public final class LoadCharactersServiceImplementation: LoadCharactersService {
    let networkSession: NetworkSession
    
    public init(networkSession: NetworkSession = NetworkSessionImplementation()) {
        self.networkSession = networkSession
    }
    
    public func loadCharacters(pageNumber: Int) async throws -> [Character] {
        let request = GetCharactersListRequest()
            .addQueryItem(name: "page", value: String(pageNumber))
        let responseData = try await networkSession.request(request)
        do {
            let decodedResponse = try JSONDecoder().decode(CharacterResponse.self, from: responseData)
            return decodedResponse.results
        } catch {
            throw RMCoreBusinessErrorFactory.mapError(code: .failedToDecode)
        }
    }
}
