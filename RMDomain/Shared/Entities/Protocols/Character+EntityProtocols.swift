import Foundation

public protocol CharacterEntityProtocol {
    var id: Int { get }
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var type: String? { get }
    var gender: String { get }
    var origin: OriginEntityProtocol { get }
    var location: LocationEntityProtocol { get }
    var image: String { get }
    var episode: [String] { get }
    var url: String { get }
    var created: String { get }
}

public protocol OriginEntityProtocol {
    var name: String { get }
    var url: String { get }
}

public protocol LocationEntityProtocol {
    var name: String { get }
    var url: String { get }
}

extension CharacterEntityProtocol {
    var id: Int {
        get { return 1 }
    }
    var name: String {
        get { return "" }
    }
    var status: String {
        get { return "" }
    }
    var species: String {
        get { return "" }
    }
    var type: String? {
        get { return "" }
    }
    var gender: String {
        get { return "" }
    }
    var origin: OriginEntityProtocol { 
        get {
            return OriginEntityProtocol.self as! OriginEntityProtocol
        }
    }
    var location: LocationEntityProtocol {
        get {
            return LocationEntityProtocol.self as! LocationEntityProtocol
        }
    }
    var image: String {
        get { return "" }
    }
    var episode: [String] {
        get { return [] }
    }
    var url: String {
        get { return "" }
    }
    var created: String {
        get { return "" }
    }
}

extension OriginEntityProtocol {
    var name: String { get { return "" } }
    var url: String { get { return "" } }
}

extension LocationEntityProtocol {
    var name: String { get { return "" } }
    var url: String { get { return "" } }
}
