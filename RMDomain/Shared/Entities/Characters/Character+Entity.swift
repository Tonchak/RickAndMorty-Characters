import Foundation
import RMCore

public struct CharacterEntity: CharacterEntityProtocol {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String?
    public let gender: String
    public let origin: OriginEntityProtocol
    public let location: LocationEntityProtocol
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    init(decodable: Character) {
        self.id = decodable.id
        self.name = decodable.name
        self.status = decodable.status
        self.species = decodable.species
        self.type = decodable.type
        self.gender = decodable.gender
        self.origin = OriginEntity(decodable: decodable.origin)
        self.location = LocationEntity(decodable: decodable.location)
        self.image = decodable.image
        self.episode = decodable.episode
        self.url = decodable.url
        self.created = decodable.created
    }
}

public struct OriginEntity: OriginEntityProtocol {
    public let name: String
    public let url: String
    init(decodable: Origin) {
        self.name = decodable.name
        self.url = decodable.url
    }
}

public struct LocationEntity: LocationEntityProtocol {
    public let name: String
    public let url: String
    init(decodable: Location) {
        self.name = decodable.name
        self.url = decodable.url
    }
}
