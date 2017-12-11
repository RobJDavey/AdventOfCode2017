import Foundation

public struct Point {
    let x: Int
    let y: Int
    let z: Int
    
    public init(_ x: Int, _ y: Int, _ z: Int) {
        precondition(x + y + z == 0)
        self.x = x
        self.y = y
        self.z = z
    }
}

extension Point {
    public static let origin = Point(0, 0, 0)
    
    public var length: Int {
        let total = abs(x) + abs(y) + abs(z)
        return total / 2
    }
    
    public func move(direction: Direction) -> Point {
        switch direction {
        case .north:
            return Point(self.x, self.y - 1, self.z + 1)
        case .northEast:
            return Point(self.x + 1, self.y - 1, self.z)
        case .southEast:
            return Point(self.x + 1, self.y, self.z - 1)
        case .south:
            return Point(self.x, self.y + 1, self.z - 1)
        case .southWest:
            return Point(self.x - 1, self.y + 1, self.z)
        case .northWest:
            return Point(self.x - 1, self.y, self.z + 1)
        }
    }
    
    public func follow(directions: [Direction]) -> [Point] {
        var current = self
        var results: [Point] = []
        
        for direction in directions {
            current = current.move(direction: direction)
            results.append(current)
        }
        
        return results
    }
    
    public func follow(directions: [Direction]) -> Point {
        var current = self
        
        for direction in directions {
            current = current.move(direction: direction)
        }
        
        return current
    }
    
    static func -(a: Point, b: Point) -> Point {
        return Point(a.x - b.x, a.y - b.y, a.z - b.z)
    }
    
    public func distance(to other: Point = .origin) -> Int {
        let point = self - other
        return point.length
    }
}
