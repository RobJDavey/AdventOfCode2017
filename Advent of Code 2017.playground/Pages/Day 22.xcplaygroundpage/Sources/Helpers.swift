import Foundation

public typealias Cell = Status
public typealias Row = [Cell]
public typealias Grid = [Row]
public typealias Point = (x: Int, y: Int)
public typealias CurrentLocation = (point: Point, direction: Direction)
public typealias StartInfo = (grid: Grid, currentLocation: CurrentLocation)
public typealias StatusTransformation = (Status) -> Status

public func part1Transformation(status: Status) -> Status {
    return status.toggle
}

public func part2Transformation(status: Status) -> Status {
    return status.next
}

public func parse(_ input: String) -> StartInfo {
    let lines = input.components(separatedBy: .newlines)
    let characters = lines.map(Array.init)
    let statuses = characters.map { $0.flatMap(Status.init) }
    let y = (statuses.count / 2)
    let x = (statuses.first!.count / 2)
    return (statuses, ((x, y), .up))
}

public func run(startInfo: StartInfo, count: Int, transform: (Status) -> Status) -> Int {
    func sizeGridIfNecessary(grid: inout Grid, point: inout Point, topCorner: inout Point) {
        let height = grid.count
        let width = grid.first!.count
        
        switch point {
        case _ where point.x < 0:
            grid = grid.map { [.clean] + $0 }
            point = Direction.right.move(point: point)
            topCorner = Direction.right.move(point: topCorner)
        case _ where point.x >= width:
            grid = grid.map { $0 + [.clean] }
        case _ where point.y < 0:
            let row = Array(repeating: Status.clean, count: width)
            grid.insert(row, at: 0)
            point = Direction.down.move(point: point)
            topCorner = Direction.down.move(point: topCorner)
        case _ where point.y >= height:
            let row = Array(repeating: Status.clean, count: width)
            grid.append(row)
        default:
            break
        }
    }
    
    var location = startInfo.currentLocation
    var grid = startInfo.grid
    var topCorner: Point = (0, 0)
    var infections = 0
    
    for _ in 0..<count {
        let point = location.point
        let cell = grid[point.y][point.x]
        let direction = cell.turn(current: location.direction)
        let newCell = transform(cell)
        grid[point.y][point.x] = newCell
        var nextPoint = direction.move(point: point)
        sizeGridIfNecessary(grid: &grid, point: &nextPoint, topCorner: &topCorner)
        location = (nextPoint, direction)
        
        if newCell == .infected {
            infections += 1
        }
    }
    
    return infections
}
