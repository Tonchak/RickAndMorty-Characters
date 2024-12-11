import Foundation

public struct Info: Decodable, Equatable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?

    public enum CodingKeys: String, CodingKey {
        case count
        case pages
        case next
        case prev
    }
}

public struct Character: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String?
    public let gender: String
    public let origin: Origin
    public let location: Location
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String

    public init(id: Int, name: String, status: String, species: String, type: String?, gender: String, origin: Origin, location: Location, image: String, episode: [String], url: String, created: String) {
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

    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
}

public struct Origin: Decodable, Equatable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

public struct Location: Decodable, Equatable {
    public let name: String
    public let url: String

    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
