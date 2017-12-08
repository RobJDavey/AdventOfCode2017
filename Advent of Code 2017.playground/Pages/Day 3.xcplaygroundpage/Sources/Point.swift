import Foundation

public struct Point {
    let x: Int
    let y: Int
    
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    public init() {
        self.init(0, 0)
    }
}

extension Point {
    public func manhattanDistance(to other: Point) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}

extension Point: Hashable {
    public var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
    
    public static func ==(left: Point, right: Point) -> Bool {
        return left.x == right.x && left.y == right.y
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "{\(x), \(y)}"
    }
}
