import Foundation

public enum Direction {
    case up, down, left, right
}

extension Direction {
    var left: Direction {
        switch self {
        case .up:
            return .left
        case .right:
            return .up
        case .down:
            return .right
        case .left:
            return .down
        }
    }
    
    var right: Direction {
        switch self {
        case .up:
            return .right
        case .right:
            return .down
        case .down:
            return .left
        case .left:
            return .up
        }
    }
    
    var reverse: Direction {
        switch self {
        case .up:
            return .down
        case .right:
            return .left
        case .down:
            return .up
        case .left:
            return .right
        }
    }
    
    public func move(point: Point) -> Point {
        switch self {
        case .up:
            return (point.x, point.y - 1)
        case .right:
            return (point.x + 1, point.y)
        case .down:
            return (point.x, point.y + 1)
        case .left:
            return (point.x - 1, point.y)
        }
    }
}
