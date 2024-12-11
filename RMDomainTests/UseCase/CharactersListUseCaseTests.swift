import XCTest
@testable import RMDomain

final class CharactersListUseCaseTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testCharactersListUseCaseImplementation() {
        let sut: CharactersListUseCase = DefaultCharactersListUseCase()
        XCTAssertNotNil(sut)
    }

    func testCharactersListUseCaseGettingList() async throws {
        let useCase: CharactersListUseCase = DefaultCharactersListUseCase()
        let sut: [CharacterEntityProtocol] = try await useCase.getCharactersByPage(1)

        XCTAssertTrue(sut.count > 0)
    }
}
