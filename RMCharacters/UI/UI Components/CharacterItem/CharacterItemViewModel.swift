import Foundation
import RMDomain

final class CharacterItemViewModel: ObservableObject {

    var data: CharacterEntityProtocol

    init(data: CharacterEntityProtocol) {
        self.data = data
    }

    func created() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date: Date = formatter.date(from: data.created) else {
            return "--"
        }
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
