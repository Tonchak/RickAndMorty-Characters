import XCTest
@testable import RMDomain

final class CharactersListUseCaseTests: XCTestCase {

    func testReturnsPageFromRepository() async throws {
        let repository = MockCharactersRepository()
        repository.stubbedPage = CharactersPage(
            characters: [.stub(id: 1, name: "Rick Sanchez")],
            nextPageNumber: 2
        )
        let sut = DefaultCharactersListUseCase(repository: repository)

        let result = try await sut.getCharactersByPage(1)

        XCTAssertEqual(result, repository.stubbedPage)
        XCTAssertEqual(repository.lastPageNumber, 1)
    }

    func testPropagatesRepositoryError() async {
        let repository = MockCharactersRepository()
        repository.stubbedError = StubError.failed
        let sut = DefaultCharactersListUseCase(repository: repository)

        do {
            _ = try await sut.getCharactersByPage(2)
            XCTFail("Expected the repository error to be thrown")
        } catch {
            XCTAssertEqual(error as? StubError, .failed)
            XCTAssertEqual(repository.lastPageNumber, 2)
        }
    }
}

private enum StubError: Error, Equatable {
    case failed
}

private final class MockCharactersRepository: CharactersRepository {
    var stubbedPage = CharactersPage(characters: [], nextPageNumber: nil)
    var stubbedError: Error?
    var lastPageNumber: Int?

    func fetchCharacters(pageNumber: Int) async throws -> CharactersPage {
        lastPageNumber = pageNumber
        if let stubbedError {
            throw stubbedError
        }
        return stubbedPage
    }
}

private extension CharacterEntity {
    static func stub(id: Int, name: String) -> CharacterEntity {
        CharacterEntity(
            id: id,
            name: name,
            status: "Alive",
            species: "Human",
            type: nil,
            gender: "Male",
            origin: OriginEntity(name: "Earth", url: ""),
            location: LocationEntity(name: "Earth", url: ""),
            image: "",
            episode: [],
            url: "",
            created: "2017-11-04T18:48:46.250Z"
        )
    }
}
