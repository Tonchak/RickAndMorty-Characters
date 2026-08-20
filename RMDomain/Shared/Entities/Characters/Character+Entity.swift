import Foundation

public struct CharacterEntity: Equatable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String?
    public let gender: String
    public let origin: OriginEntity
    public let location: LocationEntity
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    public init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String?,
        gender: String,
        origin: OriginEntity,
        location: LocationEntity,
        image: String,
        episode: [String],
        url: String,
        created: String
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

public struct OriginEntity: Equatable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

public struct LocationEntity: Equatable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
