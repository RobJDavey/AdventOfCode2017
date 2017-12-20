import Foundation

public enum Direction {
    case north, east, south, west
}

extension Direction {
    var left: Direction {
        switch self {
        case .north:
            return .west
        case .east:
            return .north
        case .south:
            return .east
        case .west:
            return .south
        }
    }
    
    var right: Direction {
        switch self {
        case .north:
            return .east
        case .east:
            return .south
        case .south:
            return .west
        case .west:
            return .north
        }
    }
    
    func move(point: Point) -> Point {
        switch self {
        case .north:
            return Point(point.x, point.y - 1)
        case .east:
            return Point(point.x + 1, point.y)
        case .south:
            return Point(point.x, point.y + 1)
        case .west:
            return Point(point.x - 1, point.y)
        }
    }
}
