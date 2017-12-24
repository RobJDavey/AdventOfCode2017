import Foundation

public enum Status {
    case clean, weakened, infected, flagged
}

extension Status{
    public init?(_ character: Character) {
        switch character {
        case "#":
            self = .infected
        case ".":
            self = .clean
        default:
            return nil
        }
    }
    
    public var next: Status {
        switch self {
        case .clean:
            return .weakened
        case .weakened:
            return .infected
        case .infected:
            return .flagged
        case .flagged:
            return .clean
        }
    }
    
    public var toggle: Status {
        switch self {
        case .clean:
            return .infected
        case .infected:
            return .clean
        default:
            fatalError()
        }
    }
    
    public func turn(current: Direction) -> Direction {
        switch self {
        case .clean:
            return current.left
        case .infected:
            return current.right
        case .weakened:
            return current
        case .flagged:
            return current.reverse
        }
    }
}

extension Status: CustomStringConvertible {
    public var description: String {
        switch self {
        case .clean:
            return "."
        case .infected:
            return "#"
        case .flagged:
            return "F"
        case .weakened:
            return "W"
        }
    }
}
