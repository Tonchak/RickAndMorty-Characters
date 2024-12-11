import Foundation

public class APISessionConfiguration {
    public static let shared = APISessionConfiguration()

    private init() { }

    var hostName = "https://rickandmortyapi.com"
}
