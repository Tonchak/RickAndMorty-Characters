import Foundation

public protocol RMCoreException: Error, Equatable {
    var code: Int { get }
    var msg: String { get }
}

public struct RMCoreUnknownError: RMCoreException {
    public let code: Int = 999
    public let msg: String = "Unknown error"
}

public struct RMAuthError: RMCoreException {
    public var code: Int = 401
    public let msg: String = "Authentication Error"
}

public struct RMRequestError: RMCoreException {
    public var code: Int = 499
    public let msg: String = "Request Error"
}

public struct RMServerError: RMCoreException {
    public var code: Int = 500
    public let msg: String = "Server Error"
}

public struct RMBusinessError: RMCoreException {
    public var code: Int
    public var msg: String

    public init(code: Int, msg: String) {
        self.code = code
        self.msg = msg
    }
}

public enum RMCoreBusinessErrorCode {
    case mappingErrorCode
    case failedToDecode
}

private let defaultBusinessCode = RMBusinessError(code: 1001, msg: "Mapping Error")

public struct RMCoreBusinessErrorFactory {
    static func mapError(_ exception: Error? = nil, code: RMCoreBusinessErrorCode) -> RMBusinessError {
        if let exc = exception as? RMBusinessError {
            return exc
        }
        return defaultBusinessCode
    }
}
