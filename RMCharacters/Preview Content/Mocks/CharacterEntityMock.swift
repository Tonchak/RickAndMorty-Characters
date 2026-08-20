import Foundation
import RMDomain

extension CharacterEntity {
    static func preview(
        id: Int = 1,
        name: String = "Morty Smith",
        status: String = "Alive",
        species: String = "Human",
        type: String? = nil,
        gender: String = "Male",
        origin: OriginEntity = OriginEntity(name: "", url: ""),
        location: LocationEntity = LocationEntity(name: "", url: ""),
        image: String = "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        episode: [String] = [],
        url: String = "",
        created: String = "2017-11-04T19:22:43.665Z"
    ) -> CharacterEntity {
        CharacterEntity(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }
}

final class PreviewCharactersListUseCase: CharactersListUseCase {
    func getCharactersByPage(_ pageNumber: Int) async throws -> CharactersPage {
        CharactersPage(characters: [.preview()], nextPageNumber: nil)
    }
}
