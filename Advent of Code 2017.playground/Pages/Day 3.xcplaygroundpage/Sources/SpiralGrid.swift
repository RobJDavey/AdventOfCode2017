import Foundation

public typealias ElementType = (point: Point, value: Int?)

public struct SpiralGrid : Sequence, IteratorProtocol {
    private let calculateValues: Bool
    private var values: [Point: Int] = [Point() : 1]
    private var layer = 1
    private var direction: Direction = .east
    private var x = -1
    private var y = 0
    
    public init(calculateValues: Bool) {
        self.calculateValues = calculateValues
    }
    
    public mutating func next() -> ElementType? {
        switch direction {
        case .east:
            x += 1
            if x == layer {
                direction = .north
            }
        case .north:
            y += 1
            if y == layer {
                direction = .west
            }
        case .west:
            x -= 1
            if -x == layer {
                direction = .south
            }
        case .south:
            y -= 1
            if -y == layer {
                direction = .east
                layer += 1
            }
        }
        
        let point = Point(x, y)
        let value: Int? = calculateValues ? calculateValueForPoint(point: point) : nil
        return (point, value)
    }
    
    private mutating func calculateValueForPoint(point: Point) -> Int {
        if let value = values[point] {
            return value
        }
        
        let adjacentPoints = getAdjacentPoints(point: point)
        let adjacentValues = adjacentPoints.flatMap { values[$0] }
        let value = adjacentValues.reduce(0, +)
        values[point] = value
        return value
    }
    
    private func getAdjacentPoints(point: Point) -> [Point] {
        var adjacentPoints: [Point] = []
        
        for x in -1...1 {
            for y in -1...1 {
                guard x != 0 || y != 0 else {
                    continue
                }
                
                let newX = point.x + x
                let newY = point.y + y
                let newPoint = Point(newX, newY)
                adjacentPoints.append(newPoint)
            }
        }
        
        return adjacentPoints
    }
}
