import XCTest
@testable import RMCore

final class RMCoreTests: XCTestCase {

    func testCharacterInit() {
        let origin = Origin(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1")
        let location = Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3")

        let sut = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: origin,
            location: location,
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z"
        )
        XCTAssertNotNil(sut)
    }
}
