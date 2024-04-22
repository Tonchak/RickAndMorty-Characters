import Foundation
@testable import RMCore

class MockNetworkSession: NetworkSessionImplementation {
    var requestHandler: (HTTPRequest) async throws -> Data = { _ in Data()}
    override func request(_ endpoint: HTTPRequest) async throws -> Data {
        return try await requestHandler(endpoint)
    }
}
