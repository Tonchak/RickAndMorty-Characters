import XCTest
@testable import RMCore

final class LoadCharactersServiceTests: XCTestCase {

    func testReturnsDecodedCharacterResponse() async throws {
        let expectedResponse = CharacterResponse.Samples.successfullResponse
        let mockNetworkSession = MockNetworkSession()

        let response = try XCTUnwrap(CharacterResponse.DataSamples.successfull)
        mockNetworkSession.requestHandler = { _ in response }

        let sut = LoadCharactersServiceImplementation(networkSession: mockNetworkSession)
        let characterResponse = try await sut.loadCharacters(pageNumber: 1)

        XCTAssertEqual(characterResponse, expectedResponse.results)
    }

    func testThrowsErrorAtFetchingCharacters() async throws {
        let mockNetworkSession = MockNetworkSession()
        mockNetworkSession.requestHandler = { _ in Data() }

        let sut = LoadCharactersServiceImplementation(networkSession: mockNetworkSession)
        do {
            _ = try await sut.loadCharacters(pageNumber: 1)
            XCTExpectFailure()
        } catch {
            let expectedError = RMCoreBusinessErrorFactory.mapError(code: .failedToDecode)
            let err = try XCTUnwrap(error as? RMBusinessError)
            XCTAssertEqual(err, expectedError)
        }
    }
}
