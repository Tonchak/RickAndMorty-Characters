import XCTest
@testable import RMCharacters

final class CharacterItemViewModelTests: XCTestCase {

    func testCharacterItemViewModelInit() {
        let sut = CharacterItemViewModel(data: .preview())
        XCTAssertNotNil(sut)
    }

    func testCharacterItemViewModelData() {
        let viewModel = CharacterItemViewModel(data: .preview())
        let sut = viewModel.data
        XCTAssertEqual(sut.name, "Morty Smith")
    }
}
