import Foundation
import RMDomain

extension CharacterEntity {
    init(dto: Character) {
        self.init(
            id: dto.id,
            name: dto.name,
            status: dto.status,
            species: dto.species,
            type: dto.type,
            gender: dto.gender,
            origin: OriginEntity(dto: dto.origin),
            location: LocationEntity(dto: dto.location),
            image: dto.image,
            episode: dto.episode,
            url: dto.url,
            created: dto.created
        )
    }
}

extension OriginEntity {
    init(dto: Origin) {
        self.init(name: dto.name, url: dto.url)
    }
}

extension LocationEntity {
    init(dto: Location) {
        self.init(name: dto.name, url: dto.url)
    }
}
