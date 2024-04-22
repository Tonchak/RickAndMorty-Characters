import Foundation

public protocol NetworkSession {
    @discardableResult
    func request(_ endpoint: HTTPRequest) async throws -> Data
}
 
public class NetworkSessionImplementation: NetworkSession {
    
    enum HTTPResponseStatus: Equatable {
        case valid
        case authError
        case requestError
        case serverError
        case unknown
        
        init(statusCode: Int) {
            switch statusCode {
            case 200...299:
                self = .valid
            case 401...403:
                self = .authError
            case 400, 404...499:
                self = .requestError
            case 500...599:
                self = .serverError
            default:
                self = .unknown
            }
        }
    }
    
    private var requestHandler: (HTTPRequest) async throws -> Data = { _ in Data()}
    let urlSession: URLSession
    let sessionConfiguration: APISessionConfiguration
    
    public init(urlSession: URLSession = URLSession.shared, sessionConfiguration: APISessionConfiguration = APISessionConfiguration.shared) {
        self.urlSession = urlSession
        self.sessionConfiguration = sessionConfiguration
    }
    
    @discardableResult
    public func request(_ endpoint: HTTPRequest) async throws -> Data {
        let urlRequest = try urlRequest(from: endpoint)
        
        let response = try await performHttpRequest(urlRequest)
        try validateResponse(response)
        let (data, _) = response
        
        return data
    }
    
    private func performHttpRequest(_ urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RMCoreUnknownError()
            }
            return (data, httpResponse)
        } catch {
            throw RMCoreUnknownError()
        }
    }
    
    private func urlRequest(from endPoint: HTTPRequest) throws -> URLRequest {
        guard let url = endPoint.url(hostName: sessionConfiguration.hostName) else {
            throw RMCoreUnknownError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.httpBody = endPoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private func validateResponse(_ response: (Data, HTTPURLResponse)) throws {
        let (_, httpResponse) = response
        let status = HTTPResponseStatus(statusCode: httpResponse.statusCode)
        
        switch status {
        case .valid, .unknown:
            return
        case .authError:
            throw RMAuthError(code: httpResponse.statusCode)
        case .requestError:
            throw RMRequestError(code: httpResponse.statusCode)
        case .serverError:
            throw RMServerError(code: httpResponse.statusCode)
        }
    }
}
