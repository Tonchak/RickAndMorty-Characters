import XCTest
@testable import RMCore
import RMDomain

final class CharacterEntityMappingTests: XCTestCase {

    func testMapsCharacterDTOToEntity() {
        let dto = CharacterResponse.Samples.successfullResponse.results[0]
        let entity = CharacterEntity(dto: dto)

        XCTAssertEqual(entity.id, dto.id)
        XCTAssertEqual(entity.name, dto.name)
        XCTAssertEqual(entity.status, dto.status)
        XCTAssertEqual(entity.species, dto.species)
        XCTAssertEqual(entity.type, dto.type)
        XCTAssertEqual(entity.gender, dto.gender)
        XCTAssertEqual(entity.origin.name, dto.origin.name)
        XCTAssertEqual(entity.origin.url, dto.origin.url)
        XCTAssertEqual(entity.location.name, dto.location.name)
        XCTAssertEqual(entity.location.url, dto.location.url)
        XCTAssertEqual(entity.image, dto.image)
        XCTAssertEqual(entity.episode, dto.episode)
        XCTAssertEqual(entity.url, dto.url)
        XCTAssertEqual(entity.created, dto.created)
    }
}
