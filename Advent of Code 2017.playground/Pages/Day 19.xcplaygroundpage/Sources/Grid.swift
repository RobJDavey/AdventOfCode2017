import Foundation

public typealias GridNext = (vector: Vector, character: Character?)
public typealias Vector = (point: Point, direction: Direction)
typealias Cell = UnicodeScalar
typealias Row = [Cell]

public struct Grid {
    let width: Int
    let height: Int
    
    private let rows: [Row]

    public init(_ string: String) {
        let lines = string.components(separatedBy: .newlines)
        let rows: [Row] = lines.map(Array.init).map { $0.flatMap { $0.unicodeScalars.first }}
        self.init(rows: rows)
    }
    
    init(rows: [Row]) {
        let width = rows.map { $0.count }.max()!
        height = rows.count
        
        self.rows = rows.map { (row: Row) -> Row in
            let other = Array(repeating: UnicodeScalar(" ")!, count: width - row.count)
            return row + other
        }
        
        self.width = width
    }
    
    public var start: Vector! {
        for y in 0..<height {
            for x in 0..<width {
                if x == 0 || x == width - 1 {
                    let cell = self[x, y]
                    if cell == "-" {
                        return (Point(x, y), x == 0 ? .east : .west)
                    }
                }
                
                if y == 0 || y == height - 1 {
                    let cell = self[x, y]
                    if cell == "|" {
                        return (Point(x, y), y == 0 ? .south : .north)
                    }
                }
            }
        }
        
        return nil
    }
    
    subscript(_ x: Int, _ y: Int) -> Cell {
        if x < 0 || x >= width || y < 0 || y >= height {
            return UnicodeScalar(" ")
        }
        
        return rows[y][x]
    }
    
    subscript(_ point: Point) -> Cell {
        return self[point.x, point.y]
    }
    
    public func next(from vector: Vector) -> GridNext? {
        return next(from: vector.point, direction: vector.direction)
    }
    
    func next(from point: Point, direction: Direction) -> GridNext? {
        let nextPoint = direction.move(point: point)
        let value = self[nextPoint]
        switch value {
        case let scalar where CharacterSet.uppercaseLetters.contains(scalar):
            return ((nextPoint, direction), Character(scalar))
        case let scalar where CharacterSet.whitespaces.contains(scalar):
            let options = [direction.left, direction.right]
            for option in options {
                let optionPoint = option.move(point: point)
                let optionCell = self[optionPoint]
                if CharacterSet.whitespaces.contains(optionCell) {
                    continue
                }
                
                return next(from: point, direction: option)
            }
            
            return nil
        default:
            return ((nextPoint, direction), nil)
        }
    }
}

extension Grid : CustomStringConvertible{
    public var description: String {
        return rows.map { String($0.map(Character.init)) }.joined(separator: "\n")
    }
}
