import Foundation

extension CharacterResponse {
    class DataSamples {
        static var successfull: Data? {
            guard let filePath = Bundle(for: self).path(forResource: "CharactersSuccessResponse", ofType: "json") else {
                return nil
            }
            return try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
        }
    }
    
    struct Samples {
        static var successfullResponse = CharacterResponse(
            info: Info(
                count: 826,
                pages: 42,
                next: "https://rickandmortyapi.com/api/character?page=2",
                prev: nil
            ),
            results: [
                Character(
                    id: 1,
                    name: "Rick Sanchez",
                    status: "Alive",
                    species: "Human",
                    type: "",
                    gender: "Male",
                    origin: Origin(
                        name: "Earth (C-137)",
                        url: "https://rickandmortyapi.com/api/location/1"
                    ),
                    location: Location(
                        name: "Citadel of Ricks",
                        url: "https://rickandmortyapi.com/api/location/3"
                    ),
                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    episode: [
                        "https://rickandmortyapi.com/api/episode/1"
                    ],
                    url: "https://rickandmortyapi.com/api/character/1",
                    created: "2017-11-04T18:48:46.250Z"
                )
            ]
        )
    }
}
