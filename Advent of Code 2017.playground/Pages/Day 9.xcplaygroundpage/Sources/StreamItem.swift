import Foundation

public enum StreamItem {
    case group([StreamItem])
    case garbage(String)
}

extension StreamItem: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .group(children):
            return "{" + children.map { $0.description }.joined(separator: ",") + "}"
        case let .garbage(value):
            return "<\(value)>"
        }
    }
}
