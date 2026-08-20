import Foundation

public struct CharactersPage: Equatable {
    public let characters: [CharacterEntity]
    public let nextPageNumber: Int?

    public init(characters: [CharacterEntity], nextPageNumber: Int?) {
        self.characters = characters
        self.nextPageNumber = nextPageNumber
    }
}
