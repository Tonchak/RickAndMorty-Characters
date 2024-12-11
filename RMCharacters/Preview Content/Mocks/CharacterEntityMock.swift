import Foundation
import RMDomain

struct CharacterEntityMock: CharacterEntityProtocol {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String?
    var gender: String
    var origin: RMDomain.OriginEntityProtocol
    var location: RMDomain.LocationEntityProtocol
    var image: String
    var episode: [String]
    var url: String
    var created: String

    init(id: Int = 1,
         name: String = "Morty Smith",
         status: String = "Alive",
         species: String = "Human",
         type: String? = nil,
         gender: String = "Male",
         origin: RMDomain.OriginEntityProtocol = MockOriginEntity(),
         location: RMDomain.LocationEntityProtocol = MockLocationEntity(),
         image: String = "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
         episode: [String] = [],
         url: String = "",
         created: String = "2017-11-04T19:22:43.665Z"
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

struct MockOriginEntity: OriginEntityProtocol {
    var name: String
    var url: String

    init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
}

struct MockLocationEntity: LocationEntityProtocol {
    var name: String
    var url: String

    init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
}
