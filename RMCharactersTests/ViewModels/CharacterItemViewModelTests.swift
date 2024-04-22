import XCTest
@testable import RMCharacters

final class CharacterItemViewModelTests: XCTestCase {
    
    func testCharacterItemViewModelInit() {
        let sut = CharacterItemViewModel(data: CharacterEntityMock())
        XCTAssertNotNil(sut)
    }
    
    func testCharacterItemViewModelData() {
        let viewModel = CharacterItemViewModel(data: CharacterEntityMock())
        let sut = viewModel.data
        XCTAssertNotNil(sut)
    }
}
