import Foundation

enum State: String {
    case a, b, c, d, e, f
}

extension State {
    init?(_ string: String) {
        self.init(rawValue: string.lowercased())
    }
}
