import Foundation

public protocol RMRepository {
    associatedtype Item
    associatedtype Service

    init(service: Service)

    func fetchCharacters(pageNumber: Int) async throws -> [Item]
}
